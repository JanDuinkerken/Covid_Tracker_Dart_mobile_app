import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dcdg/dcdg.dart';
import 'package:ipm/screens/show_db_error_dialog.dart';

class Facilities {
  final List<String> facilities;

  Facilities({required this.facilities});

  factory Facilities.fromJson(Map<String, dynamic> json) {
    List<String> facilities = [];
    if (json.isEmpty) {
      facilities = [];
    } else {
      var jsonFacilities = json["facilities"];
      for (var facility in jsonFacilities) {
        facilities.add(facility["id"].toString() + " " + facility["name"]);
      }
    }
    return Facilities(
      facilities: facilities,
    );
  }
}

Future<Facilities> fetchFac(BuildContext context) async {
  try {
     var url = Uri.parse('http://10.0.2.2:8080/api/rest/facilities');
    //var url = Uri.parse('http://192.168.0.35:8080/api/rest/facilities');

    final response = await http
        .get(url, headers: {"x-hasura-admin-secret": "myadminsecretkey"});

    if (response.statusCode == 200) {
      return Facilities.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Database Error.\n");
    }
  } catch (_) {
    showDBErrorDialog(context);
    return Facilities.fromJson({});
  }
}
