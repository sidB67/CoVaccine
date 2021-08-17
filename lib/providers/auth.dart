import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:crypto/crypto.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
class Auth extends ChangeNotifier{
  String? _token;
 late String txnid;

  bool get isAuth{
      return _token!=null;
  }

 Digest convertSHA(String otp){
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
     final url = Uri.parse('https://cdn-api.co-vin.in/api/v2/auth/public/generateOTP');
     print(phNo);
    var response = await http.post(url,
      headers: {'Content-Type':'application/json'},
      body: json.encode({
        "mobile":'$phNo'
     }
     ) );
    var responseData =  json.decode(response.body) as Map<String,dynamic>;
    txnid = responseData['txnId'];
    print(txnid);
 }


 Future<void> submitOtp(String otp)async{
    String postOtp = convertSHA(otp).toString();
                 final url = Uri.parse('https://cdn-api.co-vin.in/api/v2/auth/public/confirmOTP');
                
               var response = await http.post(url,
               headers: {'Content-Type':'application/json'},
               body: json.encode({
                "otp":'$postOtp',
                "txnId":'$txnid',
               }
               ) );
               _token = jsonDecode(response.body)['token'];
               notifyListeners();
 }

Future<void> getCertificate(String benefID)async{
   final url = Uri.parse('https://cdn-api.co-vin.in/api/v2/registration/certificate/public/download?beneficiary_reference_id=51647621450660',);
                 var response = await http.get(url,headers: {
                  "accept": "application/pdf",
                  "content-type": "application/json",
                  "authorization": "Bearer $_token"});
                
                  // print(response.body);
                  await saveAndLaunchFile(response.bodyBytes, 'Certificate.pdf');
}
}
