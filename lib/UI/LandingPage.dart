import 'package:covaccine/UI/Certificate.dart';
import 'package:covaccine/UI/authpage.dart';
import 'package:covaccine/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAuth = Provider.of<Auth>(context).isAuth;
    return isAuth? CertificatePage() : AuthPage();
  }
}