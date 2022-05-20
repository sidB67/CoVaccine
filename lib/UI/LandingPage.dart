import 'package:covaccine/UI/Certificate.dart';
import 'package:covaccine/UI/authpage.dart';
import 'package:covaccine/UI/splashscreen.dart';
import 'package:covaccine/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // late Future checkLogin;
  @override
  // void initState() {
  //   checkLogin = Provider.of<Auth>(context, listen: false).checkLogin();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    bool isAuth = Provider.of<Auth>(context).isAuth;
    print(isAuth);
    return isAuth
        ? CertificatePage()
        : FutureBuilder(
            future: Provider.of<Auth>(context, listen: false).checkLogin(),
            builder: (ctx, authResultSnapshot) {
              return authResultSnapshot.connectionState ==
                      ConnectionState.waiting
                  ? SplashScreen()
                  : AuthPage();
            });
  }
}
