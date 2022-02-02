import 'package:covaccine/UI/size_config.dart';
import 'package:covaccine/providers/auth.dart';
import 'package:covaccine/providers/sessionsData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BottomAppBar.dart' as bab;

class CertificatePage extends StatefulWidget {
  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  String benefId = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Certificate',style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout,color: Colors.black,),
            onPressed: Provider.of<Auth>(context).logout,
          ),
        ],
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
                    child: Image.asset('asset/certificate.png'),
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
                              hintText: 'Enter your Benefeciary Id',
                              hintStyle: TextStyle(color: Colors.black)),
                          onChanged: (value) {
                            benefId = value;
                          },
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await Provider.of<Auth>(context, listen: false)
                                    .getCertificate(benefId);
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
                            },
                            child: Container(
                              height: SizeConfig.safeBlockVertical * 50,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text('Get Certificate'),
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
