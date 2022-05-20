import 'package:covaccine/UI/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/info.dart';
import 'backgroundcard.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundCard(
      topMargin: 26,
      width: 320,
      height: 316,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 35, left: 30),
            height: 23,
            child: Text(
              'Select Preffered Location',
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
              width: SizeConfig.safeBlockHorizontal * 266,
              height: SizeConfig.safeBlockVertical * 51,
              margin: EdgeInsets.only(left: 30, right: 24, top: 25, bottom: 30),
              decoration: BoxDecoration(
                color: Color(0xffD7D7D7),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Pincode',
                  contentPadding: EdgeInsets.only(left: 38),
                ),
                onChanged: (value) {
                  Info.pincode = value;
                },
              )),
        ],
      ),
    );
  }
}
