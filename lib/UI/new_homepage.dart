import 'package:covaccine/UI/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewHomepage extends StatefulWidget {
  const NewHomepage({Key? key}) : super(key: key);

  @override
  State<NewHomepage> createState() => _NewHomepageState();
}

class _NewHomepageState extends State<NewHomepage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: AssetImage('asset/logo.png'),
                fit: BoxFit.cover,
              ),
            )),
        backgroundColor: Color(0xffE2A4AC),
        title: Text(
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
      ),
    );
  }
}
