import 'package:covaccine/UI/size_config.dart';
import 'package:covaccine/models/info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'backgroundcard.dart';

class DateCard extends StatefulWidget {
  DateCard({
    Key? key,
  }) : super(key: key);

  @override
  State<DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  var formatter = DateFormat('dd-MM-yyyy');

  int year = 2021;
  @override
  void initState() {
    Info.date = formatter.format(DateTime.now());
    year = int.parse(formatter.format(DateTime.now()).split('-').last);
    super.initState();
  }

  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime.now(),
            //what will be the previous supported year in picker
            lastDate: DateTime(year + 1)
            //what will be the up to supported date in picker
            )
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        Info.date = formatter.format(pickedDate);
        print(Info.date);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCard(
      height: 174,
      width: 324,
      topMargin: 44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 35, left: 30),
            height: 23,
            child: Text(
              'Select Preffered Date',
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: _pickDateDialog,
            child: Container(
                width: SizeConfig.safeBlockHorizontal * 266,
                height: SizeConfig.safeBlockVertical * 51,
                margin:
                    EdgeInsets.only(left: 30, right: 24, top: 35, bottom: 30),
                padding: EdgeInsets.only(left: 38),
                decoration: BoxDecoration(
                  color: Color(0xffD7D7D7),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${Info.date}',
                  style: TextStyle(fontSize: 16),
                )),
          ),
        ],
      ),
    );
  }
}
