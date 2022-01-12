import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
import 'package:ipm/globals.dart';
import 'package:ipm/models/facilities.dart';

class SelectionList extends StatefulWidget {
  const SelectionList({Key? key}) : super(key: key);

  @override
  _SelectionListState createState() => _SelectionListState();
}

class _SelectionListState extends State<SelectionList> {
  late String selectedValue;
  late Future<Facilities> facList;

  @override
  void initState() {
    super.initState();
    facList = fetchFac(context);
    selectedValue = "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: facList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Row(children: <Widget>[
                    Radio(
                        value: snapshot.data.facilities[index].toString(),
                        groupValue: selectedValue,
                        activeColor: Colors.grey,
                        onChanged: (s) {
                          selectedValue = s.toString();
                          Globals.facility = s.toString().substring(0, 3);
                          setState(() {});
                        }),
                    Text(
                      snapshot.data.facilities[index],
                      textScaleFactor: 1.2,
                    ),
                  ]);
                },
                separatorBuilder: (_, index) => Divider(),
                itemCount: snapshot.data.facilities.length);
          }
        });
  }
}
