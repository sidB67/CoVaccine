import 'package:covaccine/models/sessions.dart';
import 'package:flutter/material.dart';

class SessionUi extends StatelessWidget {
  SessionUi({required this.session});
  List<TableRow> _buildSlots(){
    List<TableRow> l=[
      TableRow(
        
        children: [
          Center(child: Text('S.No',style: TextStyle(fontWeight: FontWeight.w700),)),
          Center(child: Text('Timngs',style: TextStyle(fontWeight: FontWeight.w700))),
        ]
      )
    ];
    for(int i=0;i<session.slots.length;i++){
      var newRow= TableRow(
        
        children: [
          Center(child: Text('${i+1}')),
          Center(child: Text('${session.slots[i]}')),
        ]
        
      );
      l.add(newRow);
    }
    return l;
  }
  final Session session;
  @override
  Widget build(BuildContext context) {
    return  Padding(
                      padding: const EdgeInsets.only(top:16),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 7,
                        shadowColor: Colors.black,
                                              child: ExpansionTile(
                          title: Column(
                            
                            children: [
                                Container(
                                  
                                  height: 100,
                                  child: Image.network('https://mk0ehealtheletsj3t14.kinstacdn.com/wp-content/uploads/2015/07/hospital-clipart.png.jpg')),
                                  SizedBox(height:10),
                                  Text(
                                  
                                        session.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  Text(
                                        session.address,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          
                                        ),
                                      ) ,
                            ]),
                            
                                      children: [
                                        Padding(padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                                        child: Column(
                                          children: [
                                            Row(
                                          children: [
                                            Text("Fee: ${session.feeType}",
                                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(width:10),
                                            Text("Cost: ${session.fee}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
                                          ],
                                        ),
                                        
                                        Row(
                                          children: [
                                            Text("Vaccine: ${session.vaccine}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
                                            
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Minimum Age: ${session.minAgeLimit}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
                                            SizedBox(width:10), 
                                        Text("Available Capacity: ${session.availableCapacity}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
                                          ],
                                        )
                                          ],
                                        ),

                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10,0,0,10),
                                          child: Table(
                                            columnWidths: {
                                              0:FixedColumnWidth(60),
                                              1:FixedColumnWidth(150)
                                            },
                                            
                                            border: TableBorder.all(),
                                            children: _buildSlots(),
                                          ),
                                        )

                                      ],
                    ),
                      ),
    );
  }
}
