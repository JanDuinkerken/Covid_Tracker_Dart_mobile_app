import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:dcdg/dcdg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ipm/globals.dart';
import 'show_alert_dialog.dart';
import 'package:ipm/models/add_user_model.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String _scanBarcode = 'Unknown';
  String facility = Globals.facility;
  var dateTime = DateTime.now();
  var day = DateTime.now().day;
  var month = DateTime.now().month;
  var year = DateTime.now().year;
  var sec = DateTime.now().second;
  var min = DateTime.now().minute;
  var hour = DateTime.now().hour;
  var dateTimeString = DateTime.now().toIso8601String();
  var t2Temp = '';
  late int t2;
  var nombre = '';
  var apellidos = '';
  var uuid = '';
  late var entrieType = '';
  var colorEntrie = Colors.white70;
  int cnt = 0;

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = AppLocalizations.of(context)!.failedPlat;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      if (_scanBarcode.split(',').length >= 3) {
        nombre = _scanBarcode.split(',')[0];
        apellidos = _scanBarcode.split(',')[1];
        uuid = _scanBarcode.split(',')[2];
        cnt = 0;
        entrie(context, _scanBarcode.split(',')[2]).then((value){
          entrieType = value;
          if (value == 'IN'){
            colorEntrie = Colors.green;
          } else if (value == 'OUT'){
            colorEntrie = Colors.red;
          }});

        dateTime = DateTime.now();
        day = DateTime.now().day;
        month = DateTime.now().month;
        year = DateTime.now().year;
        sec = DateTime.now().second;
        min = DateTime.now().minute;
        hour = DateTime.now().hour;
        dateTimeString = DateTime.now().toIso8601String();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (_scanBarcode == 'Unknown') {
      scanQR();
    }
  }

  @override
  Widget build(BuildContext context) {
    Paint paint = Paint();
    paint.color = Colors.grey;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addUser),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Flexible(flex: 1, child: SizedBox(height: 10)),
        Flexible(
            flex: 3,
            child: Row(children: [
              Text(
                AppLocalizations.of(context)!.localization + ":",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    background: paint,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "\t$facility",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 20),
              ),
              const SizedBox(width: 50),
              ElevatedButton(
                onPressed: () => scanQR(),
                child: Text(AppLocalizations.of(context)!.scanQr,
                    textScaleFactor: 1.5),
                style: ElevatedButton.styleFrom(
                    primary: Colors.black54,
                    side: const BorderSide(
                      width: 2.0,
                      color: Colors.white,
                    )),
              ),
            ])),
        const SizedBox(height: 10),
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.name + ":",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    background: paint,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "\t$nombre",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Flexible(
            flex: 3,
            child: Row(children: [
              Text(
                AppLocalizations.of(context)!.surname + ":",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    background: paint,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "\t$apellidos",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 20),
              ),
            ])),
        const SizedBox(height: 10),
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.date + ":",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    background: paint,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "\t$day/$month/$year",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 20),
              ),
              IconButton(
                //iconSize: 50,
                icon: const Icon(Icons.calendar_today_sharp),
                onPressed: () {
                  DatePicker.showDatePicker(context, showTitleActions: true,
                      onChanged: (date) {
                    print(AppLocalizations.of(context)!.change + ' $date');
                  }, onConfirm: (date) {
                    day = date.day;
                    month = date.month;
                    year = date.year;
                    dateTimeString = date.toIso8601String();
                    print(AppLocalizations.of(context)!.confirm + ' $date');
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.hour + ":",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    background: paint,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "\t$hour:$min",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 20),
              ),
              IconButton(
                //iconSize: 50,
                icon: const Icon(Icons.access_time_sharp),
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      showTitleActions: true,
                      showSecondsColumn: false, onChanged: (date) {
                    print(AppLocalizations.of(context)!.change +
                        ' $date ' +
                        AppLocalizations.of(context)!.inTimeZone +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    hour = date.hour;
                    min = date.minute;
                    dateTimeString = date.toIso8601String();
                    print(AppLocalizations.of(context)!.confirm + ' $date');
                    setState(() {});
                  }, currentTime: DateTime.now());
                },
              ),
            ],
          ),
        ),
        //Text("Temperatura: $t2", textAlign: TextAlign.left, style: TextStyle(color: Colors.black),), //Testeo de actualizacion de valores
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  AppLocalizations.of(context)!.temperature + ":",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      background: paint,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                flex: 1,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(height: 40, width: 150),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white70, fontSize: 20),
                    onChanged: (t) {
                      setState(() {
                        t2Temp = t;
                      });
                    },
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(),
                      //hintText: 'ºC',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Flexible(
            flex: 3,
            child: Row(children: [
              Text(
                AppLocalizations.of(context)!.entrie + ":",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    background: paint,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "\t$entrieType",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: colorEntrie,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ])),
        const SizedBox(height: 30),
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, 0.3),
                child: IconButton(
                  iconSize: 50,
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    if (uuid == '') {
                      return showAlertDialog(
                          context, AppLocalizations.of(context)!.qrError);
                    }

                    if (t2Temp == '') {
                      return showAlertDialog(context,
                          AppLocalizations.of(context)!.tempMissingError);
                    } else if (double.tryParse(t2Temp) == null) {
                      return showAlertDialog(
                          context,
                          AppLocalizations.of(context)!
                              .tempNotInNumericFormError);
                    }

                    t2 = int.parse(t2Temp);
                    if (t2 <= 30 || t2 >= 50) {
                      return showAlertDialog(context,
                          AppLocalizations.of(context)!.tempNotValidError);
                    }

                    if (cnt < 2) {
                      cnt = cnt + 1;
                    } else {
                      return showAlertDialog(context,
                          AppLocalizations.of(context)!.entriesLimitPerQrError);
                    }

                    addUser(context, uuid, facility, dateTimeString, t2);
                    setState(() {
                      nombre = '';
                      apellidos = '';
                      uuid = '';
                      scanQR();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
