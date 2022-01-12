import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'add_user.dart';
import 'database.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.option)),
        body: Center(
            child: Row(
          children: [
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Expanded(
                      child: SizedBox(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey)),
                      child: Text(AppLocalizations.of(context)!.addUser),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddUser()));
                      },
                    ),
                    width: double.infinity,
                  )),
                  Expanded(
                      child: SizedBox(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black26)),
                      child: Text(AppLocalizations.of(context)!.database),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Database()));
                      },
                    ),
                    width: double.infinity,
                  ))
                ])),
          ],
        )));
  }
}
