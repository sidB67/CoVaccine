import 'package:covaccine/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BottomAppBar.dart' as bab;

class CertificatePage extends StatelessWidget {
  String benefID = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bab.BottomAppBar(
        selectedIndex: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) {
              benefID = value;
            },
          ),
          TextButton(
            onPressed: ()async{
             await Provider.of<Auth>(context,listen: false).getCertificate(benefID);
            },
            child: Text('Get Certificate'),
          ),
        ],
      ),
    );
  }
}
