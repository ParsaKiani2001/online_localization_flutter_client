import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:online_localization/src/configurations.dart';
import 'package:online_localization/src/locale_data.dart';

abstract class Apis{
  static Future<LocaleData> getLocales({bool offline = false})async{
    LocaleData data =LocaleData();
    LocaleData dataMemory = await Configurations.memory.getLocales();
    try {
      if(offline && dataMemory.locales.isNotEmpty){
        return dataMemory;
      }
      final response = await http.get(Uri.parse(
          '${Configurations.baseUrl}/API/Language?version=${Configurations
              .version}'), headers: Configurations.headers);
      if (response.statusCode == 200) {
        final utf8DecodedBody = utf8.decode(response.bodyBytes);
        List<dynamic> jsonResponse = jsonDecode(utf8DecodedBody);
        data.locales = [];
        data.names = [];
        data.icons = [];
        for (var element in jsonResponse) {
          data.locales.add(Locale(element['name'], element['local']));
          data.names.add(element['show_lang']);
          data.icons.add(element['language_icon'] == null ? null : base64Decode(
              element['language_icon']));
        }
        await Configurations.memory.setLocales(Configurations.version,data.locales,data.names,data.icons);
      }
    }catch(e){
      debugPrint(e.toString());
      if(dataMemory.locales.isEmpty){
        return Configurations.defaultLocale;
      }else{
        return dataMemory;
      }
    }
    return data;
  }

  static Future<Map<String,String>> load() async {
    Map<String,String> data = await Configurations.memory.getDictionary(version: Configurations.version,locale: Configurations.currentLocal);
    if(data.keys.isNotEmpty){
      return data;
    }
    try {
      // دریافت داده‌ها از API
      final response = await http.get(Uri.parse('${Configurations.baseUrl}/API/Dictionary/${Configurations.currentLocal.languageCode}?version=${Configurations.version}'));
      final utf8DecodedBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(utf8DecodedBody);
        data = Map<String, String>.from(jsonResponse ?? {});
        await Configurations.memory.saveDictionary(Configurations.version, data, Configurations.currentLocal);
        return data;
      }
    } catch (e) {
      debugPrint("Error loading translations: $e");
    }
    String jsonString = await rootBundle.loadString('assets/lang/app_${Configurations.defaultLocale.locales.first.languageCode}.json');
    Map<String, String> jsonMap = jsonDecode(jsonString);
    data = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return data;
  }
}