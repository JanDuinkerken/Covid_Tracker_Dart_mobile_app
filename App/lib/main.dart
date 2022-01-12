import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ipm/screens/list_page.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.grey),
    title: 'Navigation Basics',
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('en', ''),
      Locale('es', ''),
    ],
    home: ListPage(),
  ));
}
