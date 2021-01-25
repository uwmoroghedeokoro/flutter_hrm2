


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrm/employee.dart';

import 'HexColor.dart';

class personal_info extends StatefulWidget{
  employee myEmp;
  personal_info({this.myEmp});

 @override
  personal_info_page createState()=>new personal_info_page(myEmp: myEmp);

}

class personal_info_page extends State<personal_info> {
  employee myEmp;
  bool vis=false;
  personal_info_page({this.myEmp});
  final GlobalKey expansionTileKey = GlobalKey();
  final GlobalKey expansionTileKey2 = GlobalKey();

  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return 
    AnimatedOpacity(opacity:1.0 , duration: Duration(milliseconds: 1000),
     child:
        Scaffold(
          appBar: AppBar(title: Text('My Information')),
        body: Container(
        width: double.infinity,
        color: HexColor("#F7F8FE"),
        child: Column(
            children: [


              ///
              Expanded(

                  child:
                  new ListView(
                    controller: _controller,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,

                    children:  ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                          title: Text('Employee No', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                          subtitle: Text(myEmp.empno,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                          title: Text('Date of Birth', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                          subtitle: Text(myEmp.dob,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                          title: Text('Hire Date', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                          subtitle: Text('View your personal details.',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                          title: Text('TRN', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                          subtitle: Text(myEmp.trn,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                          title: Text('NIS', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                          subtitle: Text(myEmp.nis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                          title: Text('Address', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                          subtitle: Text(myEmp.address,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                          title: Text('City', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                          subtitle: Text(myEmp.city,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                          title: Text('Mobile', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                          subtitle: Text(myEmp.mobile,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                          title: Text('Email', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                          subtitle: Text(myEmp.email,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                        ),
                        ExpansionTile(title: Text('Employment Information'),
                          key: expansionTileKey,
                          onExpansionChanged: (value) {
                            if (value) { // Checking expansion status
                              _scrollToSelectedContent(expansionTileKey: expansionTileKey);
                            }
                          },
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Hire Date', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.hireDate,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Job Title', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.jobTitle,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Employment Status', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.emp_status,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Job Category', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.job_category,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Department', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.department,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),

                          ],

                        ),
                        ExpansionTile(title: Text('Salary Information'),
                          key: expansionTileKey2,
                          onExpansionChanged: (value) {
                            if (value) { // Checking expansion status
                              _scrollToSelectedContent(expansionTileKey: expansionTileKey2);
                            }
                          },
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Effective Date', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.pay_effective,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Pay Grade', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.pay_grade,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Pay Frequency', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.pay_freq,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Currency', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.pay_currency,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Annual Salary', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.pay_amount.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                              title: Text('Vehicle Allowance', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                              subtitle: Text(myEmp.pay_veh_allowance.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.black54),),
                            ),

                          ],

                        ),

                      ],
                    ).toList(),
                  )
              ),

              ///
            ]
        )


    )
    )
    );

  }

  void _scrollToSelectedContent({GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: Duration(milliseconds: 200));
      });
    }
  }

}