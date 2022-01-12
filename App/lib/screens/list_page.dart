import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'selection_list.dart';
import 'show_alert_dialog.dart';
import 'button_page.dart';
import 'package:ipm/globals.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text(AppLocalizations.of(context)!.chooseInstall)),
        body: Column(children: <Widget>[
          const Expanded(flex: 9, child: SelectionList()),
          Expanded(
              flex: 1,
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black45),
                      child: Text(AppLocalizations.of(context)!.next),
                      onPressed: () {
                        if (Globals.facility == "") {
                          showAlertDialog(
                              context, AppLocalizations.of(context)!.alert);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ButtonPage()));
                        }
                      })))
        ]));
  }
}
