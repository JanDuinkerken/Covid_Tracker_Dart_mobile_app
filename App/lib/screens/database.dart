import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ipm/globals.dart';
import 'selection_list_2.dart';

class Database extends StatefulWidget {
  const Database({Key? key}) : super(key: key);

  @override
  State<Database> createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.database),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          const SizedBox(height: 10),
          Center(
              child: Text(
            AppLocalizations.of(context)!.localization + " " + Globals.facility,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          )),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                              const BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black12)),
                      onPressed: () {
                        Globals.filtered = 1;
                        setState(() {});
                      },
                      child: Text(
                        AppLocalizations.of(context)!.rightNow,
                        textAlign: TextAlign.center,
                      )),
                ),
                Flexible(
                  flex: 3,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                              const BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black12)),
                      onPressed: () {
                        Globals.filtered = 0;
                        setState(() {});
                      },
                      child: Text(
                        AppLocalizations.of(context)!.fullList,
                        textAlign: TextAlign.center,
                      )),
                ),
              ]),
          Expanded(flex: 7, child: SelectionList2()),
        ]));
  }
}
