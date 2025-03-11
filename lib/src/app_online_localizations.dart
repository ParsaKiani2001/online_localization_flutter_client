import 'package:flutter/widgets.dart';
import 'package:online_localization/src/app_localization.dart';
import 'package:online_localization/src/configurations.dart';

class AppOnlineLocalization extends LocalizationsDelegate<AppLocalization>{
  const AppOnlineLocalization();

  @override
  bool isSupported(Locale locale) => Configurations.locals.contains(locale);

  @override
  Future<AppLocalization> load(Locale locale) async {
    Configurations.currentLocal = locale;
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(AppOnlineLocalization old) => false;
}