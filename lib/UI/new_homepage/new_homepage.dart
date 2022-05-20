import 'package:covaccine/UI/size_config.dart';
import 'package:covaccine/models/info.dart';
import 'package:covaccine/providers/sessionsData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'backgroundcard.dart';
import 'customappbar.dart';
import 'datecard.dart';
import 'locationcard.dart';

class NewHomepage extends StatefulWidget {
  const NewHomepage({Key? key}) : super(key: key);

  @override
  State<NewHomepage> createState() => _NewHomepageState();
}

class _NewHomepageState extends State<NewHomepage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<SessionsData>(context, listen: false)
              .getSessions(Info.pincode, Info.date),
        ),
        body: Column(
          children: [
            CustomAppBar(),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  DateCard(),
                  LocationCard(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
