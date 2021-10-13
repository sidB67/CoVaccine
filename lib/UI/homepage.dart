import 'package:covaccine/UI/sessionUI.dart';
import 'package:covaccine/UI/size_config.dart';
import 'package:covaccine/providers/sessionsData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'BottomAppBar.dart' as bab;
import 'package:intl/intl.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pincode = '';
  var formatter = DateFormat('dd-MM-yyyy');
  String date = '';
  int year = 2021;
  @override
  void initState() {
    super.initState();
   date = formatter.format(DateTime.now());
   year = int.parse(formatter.format(DateTime.now()).split('-').last);
    print(date);
    print(year);
    setState(() {
      
    });
  }
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime.now(),
            //what will be the previous supported year in picker
            lastDate: DateTime(year+1)
                 //what will be the up to supported date in picker
        ).then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        date = formatter.format(pickedDate);
        print(date);
      });
    });
  }
  
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final sessions = Provider.of<SessionsData>(context).session;

    SizeConfig().init(context);
    print('build');
    return Scaffold(
      bottomNavigationBar: bab.BottomAppBar(
        selectedIndex: 0,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('CoVaccine',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 20,
              left: SizeConfig.safeBlockHorizontal * 10,
              right: SizeConfig.safeBlockHorizontal * 10,
            ),
            color: Colors.grey[200],
            width: double.infinity,
            height: SizeConfig.safeBlockVertical * 200,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: FittedBox(
                            child: Text(
                              "Enter Pin Code",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.5),
                                  fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // SizedBox(height:10),
                        Container(
                            // height: 60,
                            padding: EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6)
                              ],
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "110051"),
                              onChanged: (value) => pincode = value,
                            )),
                      ],
                    )),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: FittedBox(
                              child: Text(
                                "Enter Date in the given format",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.5),
                                    fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          // SizedBox(height:10),
                          GestureDetector(
                            onTap: _pickDateDialog,
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '$date',
                                style: TextStyle(
                                  fontSize: 16
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
                  child: MaterialButton(
                    color: Colors.greenAccent,
                    shape: CircleBorder(),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await Provider.of<SessionsData>(context, listen: false)
                            .getSessions(pincode, date);
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
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.search)),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Expanded(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
              : Expanded(
                  child: sessions.length == 0
                      ? Text('No Match Found')
                      : RefreshIndicator(
                          onRefresh: () async {
                            await Provider.of<SessionsData>(context,
                                    listen: false)
                                .getSessions(pincode, date);
                          },
                          child: ListView.builder(
                            itemCount: sessions.length,
                            itemBuilder: (BuildContext context, int index) {
                              List s = sessions;
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SessionUi(
                                    session: s[index],
                                  ));
                            },
                          ),
                        ),
                ),
        ],
      ),
    );
  }
}