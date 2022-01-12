import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ipm/globals.dart';
import 'package:ipm/models/access.dart';

class SelectionList2 extends StatefulWidget {
  const SelectionList2({Key? key}) : super(key: key);

  @override
  _SelectionList2State createState() => _SelectionList2State();
}

class _SelectionList2State extends State<SelectionList2> {
  late Future<Access> accessList;

  @override
  Widget build(BuildContext context) {
    accessList = fetchAccess(Globals.filtered, context);
    return Column(children: [
      Expanded(
          flex: 1,
          child: FutureBuilder(
              future: accessList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return Text(
                          snapshot.data.accesses[index],
                          textScaleFactor: 1.3,
                        );
                      },
                      separatorBuilder: (_, index) => Divider(),
                      itemCount: snapshot.data.accesses.length);
                }
              })),
      Center(
          child: FutureBuilder(
              future: accessList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                      child: Text(
                    AppLocalizations.of(context)!.totalEntries +
                        snapshot.data.accesses.length.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ));
                }
              }))
    ]);
  }
}
