import 'package:flutter/material.dart';
import 'BottomAppBar.dart' as bab;
class CertificatePage extends StatelessWidget {
  const CertificatePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bab.BottomAppBar(selectedIndex: 1,) ,
    );
  }
}