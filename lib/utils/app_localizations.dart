import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

AppLocalizations? getAppLocalizations(BuildContext context) {
  return AppLocalizations.of(context);
}

Future<AppLocalizations> loadLocalization() async {
  final parts = Intl.getCurrentLocale().split('_');
  final locale = Locale(parts.first, parts.last);
  return AppLocalizations.delegate.load(locale);
}
