import 'package:flutter/widgets.dart';
import 'package:online_localization/src/apis.dart';

class AppLocalization{
  final Locale locale;
  late Map<String, String> _localizedStrings;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  Future<bool> load() async {
    _localizedStrings = await Apis.load();
    return true;
  }

  String translate(Enum key) {
    return _localizedStrings[key.name.toString()] ?? key.name.toString();
  }
}