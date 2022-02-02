import 'package:covaccine/UI/size_config.dart';
import 'package:covaccine/providers/auth.dart';
import 'package:covaccine/providers/sessionsData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BottomAppBar.dart' as bab;

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String phNo = '';
  bool isLoading = false;
  @override
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Continue with Mobile',style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: bab.BottomAppBar(
        selectedIndex: 2,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Flexible(
                  child: Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig.safeBlockVertical * 50),
                    width: SizeConfig.safeBlockHorizontal * 300,
                    height: SizeConfig.safeBlockVertical * 300,
                    child: Image.asset('asset/phone.png'),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 20,
                      left: SizeConfig.safeBlockHorizontal * 20,
                      right: SizeConfig.safeBlockHorizontal * 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: SizeConfig.safeBlockHorizontal * 10),
                              hintText: 'Enter your mobile number',
                              hintStyle: TextStyle(color: Colors.black)),
                              keyboardType: TextInputType.number,
                          onChanged: (value) {
                            phNo = value;
                          },
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap:_phoneController.text.length==10? () async {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await Provider.of<Auth>(context, listen: false)
                                    .getOTP(phNo);
                                Navigator.pushNamed(context, 'enter-otp');
                              } catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text('Error Occured'),
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
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }:null,
                            child: Container(
                              height: SizeConfig.safeBlockVertical * 50,
                              decoration: BoxDecoration(
                                color:_phoneController.text.length==10? Colors.greenAccent:Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text('Get OTP'),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
