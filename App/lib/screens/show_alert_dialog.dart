import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';

showAlertDialog(BuildContext context, String error) {
  // Create AlertDialog
  SnackBar snackBar = SnackBar(
      content: Text(error),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ));

  // show the dialog
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
