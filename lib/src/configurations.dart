
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:online_localization/src/apis.dart';
import 'package:online_localization/src/locale_data.dart';
import 'package:online_localization/src/memory_controller.dart';

abstract class Configurations {
  static int version = 1;
  static String baseUrl = 'http://127.0.0.1:5000';
  static List<Locale> locals = [Locale('en','US')];
  static List<String> languages = ['English'];
  static List<Uint8List?> icons = [null];
  static Locale currentLocal = Locale('en','US');
  static Map<String,String> headers = {};
  static MemoryController memory = MemoryController();
  static LocaleData defaultLocale = LocaleData()..locales = [Locale('en','US')]..icons=[null]..names=['English'];
  static void init(){
    memory.init();
  }
  static Future<void> getLocales({bool offline = false})async{
    await Apis.getLocales(offline: offline);
  }
}