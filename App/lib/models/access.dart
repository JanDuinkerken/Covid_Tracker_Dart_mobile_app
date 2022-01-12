import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dcdg/dcdg.dart';
import 'package:ipm/screens/show_db_error_dialog.dart';
import 'package:ipm/globals.dart';

class Access {
  final List<String> accesses;

  Access({required this.accesses});

  factory Access.fromJson(Map<String, dynamic> json, int filtered) {
    var jsonAccesses = json["access_log"];
    var now = [];
    var out = [];
    int removed = 0;
    List<String> accesses = [];
    if (json.isEmpty) {
    } else {
      if (filtered == 1) {
        for (var log in jsonAccesses) {
          if (log["type"] == "OUT") {
            out.add(log);
          } else {
            for (var x in out) {
              if (log["user"]["uuid"] == x["user"]["uuid"]) {
                removed = 1;
                out.remove(out.indexOf(x));
              }
            }
            if (removed == 0) {
              now.add(log);
            } else {
              removed = 0;
            }
          }
        }
      }
      var finalList;
      if (filtered == 1) {
        finalList = now;
      } else {
        finalList = jsonAccesses;
      }
      for (var access in finalList) {
        String date = access["timestamp"].toString().substring(0, 10) +
            " " +
            access["timestamp"].toString().substring(11, 19);
        accesses.add(access["user"]["name"] +
            " " +
            access["user"]["surname"] +
            ": " +
            date +
            " Temp: " +
            access["temperature"] +
            " - " +
            access["type"]);
      }
    }
    return Access(
      accesses: accesses,
    );
  }
}

Future<Access> fetchAccess(int filtered, BuildContext context) async {
  try {
     var url = Uri.parse(
        'http://10.0.2.2:8080/api/rest/facility_access_log/' +
            Globals.facility);
    // var url = Uri.parse(
    //     'http://192.168.0.35:8080/api/rest/facility_access_log/' +
    //         Globals.facility);

    final response = await http
        .get(url, headers: {"x-hasura-admin-secret": "myadminsecretkey"});

    if (response.statusCode == 200) {
      return Access.fromJson(jsonDecode(response.body), filtered);
    } else {
      throw Exception("Database Error.\n");
    }
  } catch (_) {
    showDBErrorDialog(context);
    return Access.fromJson({}, filtered);
  }
}
