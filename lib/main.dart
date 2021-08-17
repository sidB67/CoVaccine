import 'package:covaccine/UI/homepage.dart';
import 'package:covaccine/providers/sessionsData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SessionsData())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        primaryColor: Colors.white
          
        ),
        home: HomePage(),
      ),
    );
  }
}

