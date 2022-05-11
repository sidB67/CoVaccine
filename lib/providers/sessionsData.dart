import 'dart:convert';
import 'package:covaccine/models/sessions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class States {
  final int stateId;
  final stateName;
  States({
    required this.stateId,
    this.stateName,
  });
}

class District {
  final int districtId;
  final districtName;
  District({
    required this.districtId,
    this.districtName,
  });
}

class SessionsData with ChangeNotifier {
  List _sessions = [];
  List _states = [];
  List _districts = [];
  List _districtSessions = [];
  Future<void> getSessions(String pincode, String date) async {
    print('called');
    final url = Uri.parse(
        "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$pincode&date=$date");

    print(url);
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final extractedData = responseData["sessions"] as List;
        extractedData.forEach((element) {
          List<String> slotList = [];
          final extractedSlots = element["slots"] as List;

          extractedSlots.forEach((element) {
            slotList.add(element["time"]);
          });

          print(slotList);
          _sessions.add(Session(
            name: element["name"],
            address: element["address"],
            feeType: element["fee_type"],
            availableCapacity: element["available_capacity"],
            fee: element["fee"],
            minAgeLimit: element["min_age_limit"],
            vaccine: element["vaccine"],
            slots: slotList,
            lat: element["lat"].toDouble(),
            long: element["long"].toDouble(),
          ));
        });
      } else {
        final responseData = jsonDecode(response.body);
        var error = responseData["error"];
        throw error;
      }
    } catch (e) {
      rethrow;
    }

    print(_sessions.length);

    notifyListeners();
  }

  Future<void> getStates() async {
    print('called');
    final url =
        Uri.parse("https://cdn-api.co-vin.in/api/v2/admin/location/states");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final extractedData = responseData["states"];
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
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> getDistrict(int state_id) async {
    List loadedData = [];
    print('called');
    final url = Uri.parse(
        "https://cdn-api.co-vin.in/api/v2/admin/location/districts/${state_id}");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final extractedData = responseData["districts"];
        _districts.clear();
        final loadedSessions = extractedData.forEach((element) {
          loadedData.add(District(
            districtId: element["district_id"],
            districtName: element["district_name"],
          ));
        });
      } else {
        final responseData = jsonDecode(response.body);
        var error = responseData["error"];
        throw error;
      }
      _districts = loadedData;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> getDistrictSessions(int district_id, String date) async {
    print('called');
    final url = Uri.parse(
        "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=$district_id&date=$date");
    print(url);
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final extractedData = responseData["sessions"] as List;
        extractedData.forEach((element) {
          List<String> slotList = [];
          final extractedSlots = element["slots"] as List;

          extractedSlots.forEach((element) {
            slotList.add(element["time"]);
          });

          print(slotList);
          _districtSessions.add(Session(
            name: element["name"],
            address: element["address"],
            feeType: element["fee_type"],
            availableCapacity: element["available_capacity"],
            fee: element["fee"],
            minAgeLimit: element["min_age_limit"],
            vaccine: element["vaccine"],
            slots: slotList,
            lat: element["lat"].toDouble(),
            long: element["long"].toDouble(),
          ));
        });
      } else {
        final responseData = jsonDecode(response.body);
        var error = responseData["error"];
        throw error;
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  List<Session> get session {
    return [..._sessions];
  }

  List<States> get states {
    return [..._states];
  }

  List<District> get districts {
    return [..._districts];
  }

  List<Session> get districtSessions {
    return [..._districtSessions];
  }

  void clearSessions2() {
    _sessions = [];
    _districtSessions = [];
    notifyListeners();
  }
}
