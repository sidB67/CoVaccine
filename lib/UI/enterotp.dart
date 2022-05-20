import 'package:covaccine/UI/size_config.dart';
import 'package:covaccine/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BottomAppBar.dart' as bab;

class EnterOTP extends StatefulWidget {
  @override
  _EnterOTPState createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  String otp = '';
  bool isLoading = false;
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Confirm OTP', style: TextStyle(color: Colors.black)),
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
                    child: Image.asset('asset/otp.png'),
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
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: SizeConfig.safeBlockHorizontal * 10),
                              hintText: 'Enter your OTP',
                              hintStyle: TextStyle(color: Colors.black)),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              otp = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: otp.length == 6
                                ? () async {
                                    print('pressed');
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      await Provider.of<Auth>(context,
                                              listen: false)
                                          .submitOtp(otp);
                                      isError = false;
                                    } catch (e) {
                                      isError = true;
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
                                      if (isError == false) {
                                        Navigator.pushReplacementNamed(
                                            context, 'land-page');
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  }
                                : null,
                            child: Container(
                              height: SizeConfig.safeBlockVertical * 50,
                              decoration: BoxDecoration(
                                color: otp.length == 6
                                    ? Colors.greenAccent
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text('Submit OTP'),
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
