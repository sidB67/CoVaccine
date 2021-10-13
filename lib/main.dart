
import 'package:covaccine/UI/LandingPage.dart';
import 'package:covaccine/UI/enterotp.dart';
import 'package:covaccine/UI/homepage.dart';
import 'package:covaccine/providers/auth.dart';
import 'package:covaccine/providers/sessionsData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feedback/feedback.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SessionsData()),
        ChangeNotifierProvider.value(value: Auth())
      ],
      child: BetterFeedback(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primaryColor: Colors.white),
          routes: {
            'home-page': (ctx) => HomePage(),
            'land-page': (ctx) => LandingPage(),
            'enter-otp': (ctx) => EnterOTP(),
          },
          initialRoute: 'home-page',
        ),
      ),
    );
  }
}
