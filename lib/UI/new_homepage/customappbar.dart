import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 25),
        width: double.infinity,
        height: SizeConfig.safeBlockVertical * 105,
        color: Color(0xffE2A4AC),
        child: Row(
          children: [
            Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: AssetImage('asset/logo.png'),
                    fit: BoxFit.cover,
                  ),
                )),
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 15,
            ),
            Text(
              'CoVaccine',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: SizeConfig.safeBlockVertical * 24,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
