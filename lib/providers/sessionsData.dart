import 'dart:convert';

import 'package:covaccine/models/sessions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class States{
  final int stateId;
  final stateName;
  States({
     required this.stateId,
     this.stateName,
  });
  }

class SessionsData with ChangeNotifier {
  List _sessions = [];
  List _states = [];
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
  Future<void> getStates() async {
    print('called');
    final url = Uri.parse(
        "https://cdn-api.co-vin.in/api/v2/admin/location/states");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final extractedData = responseData["states"] ;
        final loadedSessions = extractedData.forEach((element) { 
          _states.add(States(
            stateId: element["state_id"],
            stateName: element["state_name"],
          ));
        });
            
        
      } else {
        final responseData = jsonDecode(response.body);
        var error = responseData["error"];
        throw error;
      }

     _states.forEach((element) {
       print(element.stateName);
     });
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  List<Session> get session {
    return [..._sessions];
  }
  List<States> get states {
    return [..._states];
  }
}

