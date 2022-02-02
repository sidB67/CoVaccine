import 'package:covaccine/providers/sessionsData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({ Key? key }) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
   void initialiseState() async {
   
    try {
      await Provider.of<SessionsData>(context, listen: false).getStates();
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Unable to Load States,Only Pincode will work'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'))
              ],
            );
          });
    } finally {
      Navigator.pushReplacementNamed(context, 'home-page');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
      
    );
  }
}