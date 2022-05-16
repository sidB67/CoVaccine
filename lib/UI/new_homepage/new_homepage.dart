import 'package:covaccine/UI/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'backgroundcard.dart';
import 'customappbar.dart';
import 'datecard.dart';

class NewHomepage extends StatefulWidget {
  const NewHomepage({Key? key}) : super(key: key);

  @override
  State<NewHomepage> createState() => _NewHomepageState();
}

class _NewHomepageState extends State<NewHomepage> {
  String date = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                DateCard(
                  date: date,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
