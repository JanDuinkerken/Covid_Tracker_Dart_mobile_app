import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dcdg/dcdg.dart';
import 'package:ipm/screens/show_db_error_dialog.dart';

void addUser(context, uuid, facility, dateTimeString, t2) async {
  try {
    entrie(context, uuid).then((value) async {
      var type = '';

      type = value;

      var dataAdd = {
        //Su ultima entrada en la tabla es un IN
        "user_id": "$uuid",
        "facility_id": "$facility",
        "timestamp": "$dateTimeString",
        "type": "$type",
        "temperature": "$t2"
      };

      var urlAdd = Uri.parse("http://10.0.2.2:8080/api/rest/access_log");
      //Uri.parse("http://192.168.0.35:8080/api/rest/access_log");

      var response = await http.post(
        urlAdd,
        headers: {
          "x-hasura-admin-secret": "myadminsecretkey",
        },
        body: json.encode(dataAdd),
      );

      if (response.statusCode != 200) {
        throw Exception("Database Error.\n");
      }

      });

  } catch (_) {
    showDBErrorDialog(context);
  }
}

Future<String> entrie(context, uuid) async {
  var type = '';
  try {
    var url = Uri.parse("http://10.0.2.2:8080/api/rest/user_access_log/$uuid");
    //var url = Uri.parse("http://192.168.0.12:8080/api/rest/user_access_log/" + uuid);
    //var url = Uri.parse("http://192.168.0.35:8080/api/rest/user_access_log/$uuid");
    //var url = Uri.parse("http://192.168.0.40:8080/api/rest/user_access_log/" + uuid);
    var r = await http.get(
      url,
      headers: {
        "x-hasura-admin-secret": "myadminsecretkey",
      },
    );

    Map<String, dynamic> map = jsonDecode(r.body);
    List<dynamic> data = map["access_log"];

    String inOut = '';

    inOut = data[data.length - 1]["type"];

    if (inOut == 'IN') {
      print("OUT");
      type = 'OUT';
    } else {
      print("IN");
      type = 'IN';
    }
  } catch (_) {
    showDBErrorDialog(context);
  }
  return type;
}