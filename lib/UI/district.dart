import 'package:covaccine/UI/sessionUI.dart';
import 'package:covaccine/UI/size_config.dart';
import 'package:covaccine/providers/sessionsData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'BottomAppBar.dart' as bab;

class DistrictSearch extends StatefulWidget {
  const DistrictSearch({Key? key}) : super(key: key);

  @override
  _DistrictSearchState createState() => _DistrictSearchState();
}

class _DistrictSearchState extends State<DistrictSearch> {
  String pincode = '';
  var formatter = DateFormat('dd-MM-yyyy');
  String date = '';
  int year = 2021;
  bool isStatesLoading = false;
  @override
  void initState() {
   
    super.initState();
    date = formatter.format(DateTime.now());
    year = int.parse(formatter.format(DateTime.now()).split('-').last);
    
    
    setState(() {});
  }
@override
 

  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime.now(),
            //what will be the previous supported year in picker
            lastDate: DateTime(year + 1)
            //what will be the up to supported date in picker
            )
        .then((pickedDate) {
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

  List<DropdownMenuItem<int>> getMenuItems(List<States> states) {
    List<DropdownMenuItem<int>> items = [];
    states.forEach((element) {
      items.add(
        DropdownMenuItem(
          child: Text(element.stateName),
          value: element.stateId,
        ),
      );
    });

    return items;
  }

  List<DropdownMenuItem<int>> getDistrictItems(List<District> district) {
    List<DropdownMenuItem<int>> items = [];
    district.forEach((element) {
      items.add(
        DropdownMenuItem(
          child: Text(element.districtName),
          value: element.districtId,
        ),
      );
    });

    return items;
  }

  var selectedState;
  var selectedDistrict;
  List<District> districts = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final districtSessions =
        Provider.of<SessionsData>(context).districtSessions;
    final states = Provider.of<SessionsData>(context).states;
    districts = Provider.of<SessionsData>(context).districts;
    SizeConfig().init(context);
    print('build');
    return Scaffold(
      bottomNavigationBar: bab.BottomAppBar(
        selectedIndex: 1,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'CoVaccine',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: isStatesLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: SizeConfig.safeBlockVertical * 20,
                    left: SizeConfig.safeBlockHorizontal * 10,
                    right: SizeConfig.safeBlockHorizontal * 10,
                  ),
                  color: Colors.grey[200],
                  width: double.infinity,
                  height: SizeConfig.safeBlockVertical * 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Container(
                            height: SizeConfig.safeBlockVertical * 80,
                            padding: EdgeInsets.only(left: 12),
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.safeBlockVertical * 10,
                                left: SizeConfig.safeBlockHorizontal * 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<int>(
                              underline: null,
                              isDense: true,
                              menuMaxHeight: SizeConfig.safeBlockVertical * 350,
                              hint: Text('Select the State'),
                              value: selectedState,
                              items: getMenuItems(states),
                              onChanged: (value) async {
                                setState(() {
                                  selectedState = value;
                                  selectedDistrict = null;
                                });
                                await Provider.of<SessionsData>(context,
                                        listen: false)
                                    .getDistrict(value!);
                              },
                            )),
                      ),
                      Flexible(
                        child: Container(
                            height: SizeConfig.safeBlockVertical * 80,
                            padding: EdgeInsets.only(left: 12),
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.safeBlockVertical * 10,
                                left: SizeConfig.safeBlockHorizontal * 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<int>(
                              hint: Text('Select the District'),
                              underline: null,
                              isDense: true,
                              menuMaxHeight: SizeConfig.safeBlockVertical * 350,
                              value: selectedDistrict,
                              items: getDistrictItems(districts),
                              onChanged: (value) {
                                setState(() {
                                  selectedDistrict = value;
                                });
                              },
                            )),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: _pickDateDialog,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.safeBlockHorizontal * 10),
                              width: SizeConfig.safeBlockHorizontal * 200,
                              height: 48,
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '$date',
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.safeBlockVertical * 20,
                              bottom: SizeConfig.safeBlockVertical * 8),
                          child: MaterialButton(
                            color: Colors.greenAccent,
                            shape: CircleBorder(),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await Provider.of<SessionsData>(context,
                                        listen: false)
                                    .getDistrictSessions(
                                        selectedDistrict, date);
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
                        child: districtSessions.length == 0
                            ? Text('No Match Found')
                            : RefreshIndicator(
                                onRefresh: () async {
                                  await Provider.of<SessionsData>(context,
                                          listen: false)
                                      .getSessions(pincode, date);
                                },
                                child: ListView.builder(
                                  itemCount: districtSessions.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List s = districtSessions;
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
