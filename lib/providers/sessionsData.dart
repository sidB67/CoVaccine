import 'dart:convert';

import 'package:covaccine/models/sessions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SessionsData with ChangeNotifier {
  List _sessions = [];

  Future<void> getSessions(String pincode, String date) async {
    print('called');
    final url = Uri.parse(
        "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$pincode&date=$date");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Iterable extractedData = responseData["sessions"];
        List loadedSessions =
            extractedData.map((json) => Session.fromJson(json)).toList();
        _sessions = loadedSessions;
      } else {
        final responseData = jsonDecode(response.body);
        var error = responseData["error"];
        throw error;
      }

      print(_sessions.length);
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  List<Session> get session {
    return [..._sessions];
  }
}
