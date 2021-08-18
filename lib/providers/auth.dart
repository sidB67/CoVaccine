import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:crypto/crypto.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  String? _token;
  late String txnid;
  Timer? _authTimer;
  bool get isAuth {
    return _token != null;
  }

  Digest convertSHA(String otp) {
    var bytes = utf8.encode(otp); // data being hashed
    var digest = sha256.convert(bytes);
    return digest;
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())?.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }

  Future<void> getOTP(String phNo) async {
    final url =
        Uri.parse('https://cdn-api.co-vin.in/api/v2/auth/public/generateOTP');
    print(phNo);
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({"mobile": '$phNo'}));
      var responseData = json.decode(response.body) as Map<String, dynamic>;
      txnid = responseData['txnId'];
      print(txnid);
    } catch (e) {
      throw e;
    }
  }

  Future<void> submitOtp(String otp) async {
    String postOtp = convertSHA(otp).toString();
    final url =
        Uri.parse('https://cdn-api.co-vin.in/api/v2/auth/public/confirmOTP');
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "otp": '$postOtp',
            "txnId": '$txnid',
          }));
      _token = jsonDecode(response.body)['token'];
      final userData = json.encode({'token': _token});
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', userData);
      notifyListeners();
      _autoLogout();
    } catch (e) {
      throw e;
    }
  }

  Future<void> getCertificate(String benefID) async {
    final url = Uri.parse(
      'https://cdn-api.co-vin.in/api/v2/registration/certificate/public/download?beneficiary_reference_id=51647621450660',
    );
    var response = await http.get(url, headers: {
      "accept": "application/pdf",
      "content-type": "application/json",
      "authorization": "Bearer $_token"
    });

    // print(response.body);
    await saveAndLaunchFile(response.bodyBytes, 'Certificate.pdf');
  }

  void logout() async {
    _token = null;
    notifyListeners();
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }

    _authTimer = Timer(Duration(minutes: 15), logout);
  }

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    _token = extractedData['token'];

    notifyListeners();
    _autoLogout();
    return true;
  }
}
