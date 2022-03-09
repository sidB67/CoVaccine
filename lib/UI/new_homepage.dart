import 'package:flutter/material.dart';

class NewHomepage extends StatefulWidget {
  const NewHomepage({Key? key}) : super(key: key);

  @override
  State<NewHomepage> createState() => _NewHomepageState();
}

class _NewHomepageState extends State<NewHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE2A4AC),
        title: Text(
          'CoVaccine',
          style: ,
          ),
      ),
    );
  }
}
