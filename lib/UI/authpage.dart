import 'package:covaccine/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  
  String phNo = '';
  String otp = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
              onChanged: (value) {
                phNo = value;
              },
            ),
            TextButton(
              onPressed: () async {
                await Provider.of<Auth>(context,listen: false).getOTP(phNo);
              },
              child: Text('Get OTP'),
            ),
             TextField(
              onChanged: (value) {
                otp = value;
              },

            ),
            TextButton(
              onPressed: () async {
                await Provider.of<Auth>(context,listen: false).submitOtp(otp);
              },
              child: Text('Submit OTP'),
              ),
        ],
      ),
    );
  }
}