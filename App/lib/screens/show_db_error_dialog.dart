import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';

showDBErrorDialog(BuildContext context) {
  // Create button
  Widget okButton =
      TextButton(child: const Text("OK"), onPressed: () => Navigator.of(context).pop());

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error"),
    content: Text(AppLocalizations.of(context)!.dbError),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
