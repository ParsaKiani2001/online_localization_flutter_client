import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:online_localization/src/locale_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoryController {
  late final SharedPreferences _prefs;

  void init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<LocaleData> getLocales({int version = 1}) async {
    LocaleData data = LocaleData();
    data.names = _prefs.getStringList('names_$version') ?? [];
    data.icons = (_prefs.getStringList('icons_$version') ?? []).map((e)=>e.isEmpty ? null:Uint8List.fromList(base64Decode(e))).cast<Uint8List?>().toList();
    data.locales = (_prefs.getStringList('locales_$version') ?? []).map((e)=>Locale(e.split('_')[1],e.split('_')[2])).toList();
    return data;
  }

  Future<Map<String,String>> getDictionary({int version = 1,Locale locale =const Locale('en','US')})async{
    Map<String,String> data = {};
    for (String element in (_prefs.getStringList('${version}_${locale.languageCode}_${locale.countryCode}')??[])) {
      data[element.split('_!@!_')[0]] = element.split('_!@!_')[1];
    }
    return data;
  }

  Future<void> setLocales(int version, List<Locale> locales, List<String> names,
      List<Uint8List?> icons) async {
    await _prefs.setInt('version', version);
    await _prefs.setStringList('locales_$version',
        locales.map((e) => '${version}_${e.languageCode}_${e.countryCode}',)
            .toList()
    );
    await _prefs.setStringList('names_$version', names);
    await _prefs.setStringList('icons_$version',
        icons.map((e) => e == null ? '' : base64Encode(e.toList())).toList());
  }

  Future<void> saveDictionary(int version,Map<String,String> dictionary,Locale locale)async{
    await _prefs.setStringList('${version}_${locale.languageCode}_${locale.countryCode}',
      [
        for(int index=0; index< dictionary.values.length;index ++ )'${dictionary.keys.toList()[index]}_!@!_${dictionary.values.toList()[index]}'
      ]
    );
  }
}