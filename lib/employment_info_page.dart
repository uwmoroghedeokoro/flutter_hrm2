
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrm/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'HexColor.dart';

class employment_info_page extends StatelessWidget {
  employee myEmp;
  bool vis=false;
  employment_info_page({this.myEmp,this.vis});
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      AnimatedOpacity(opacity: vis? 1.0 : 0.0, duration: Duration(milliseconds: 1000),
          child:
          Scaffold(
              body: Container(
                  width: double.infinity,
                  color: HexColor("#F7F8FE"),
                  child: Column(
                      children: [

                        Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          color: Colors.indigoAccent,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(myEmp.fname + ' ' + myEmp.lname,style:TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold)),
                                Text('Employment Details',style:TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.normal)),
                              ]
                          ),
                        ),
                        SizedBox(height: 30,),
                        ///
                        Expanded(
                            flex: 3,
                            child:

                                Column(
                                  children: [
                            new ListView(
                              controller: _controller,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,

                              children:  ListTile.divideTiles(
                                context: context,
                                tiles: [
                                  ListTile(
                                    contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                    title: Text('Hire Date', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                    subtitle: Text(myEmp.hireDate,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                    title: Text('Job Title', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                    subtitle: Text(myEmp.jobTitle,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                    title: Text('Employment Status', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                    subtitle: Text(myEmp.emp_status,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                    title: Text('Job Category', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                    subtitle: Text(myEmp.job_category,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                    title: Text('Department', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                    subtitle: Text(myEmp.department,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                  ),

                                ],
                              ).toList(),
                            )
                                    ,

                                    Expanded(
                                        child:
                                        Container(
                                          margin: EdgeInsets.only(left: 20,top:20),
                                       child:
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('My Managers', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                    Expanded(
                                        child:
                                        ListView.builder(
                                            itemCount: myEmp.sups==null? 0: myEmp.sups.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return new Container(

                                                padding: EdgeInsets.all(10),
                                                child:
                                                Row(
                                                children: [Icon(Icons.supervised_user_circle_outlined,color:Colors.green),SizedBox(width:10),Text(myEmp.sups[index].sub_sup_name)]
                                                )
                                              );
                                            }
                                        )
                                    )
                                           ]
                                        )
                                        )
                                    )
                            ]
                                )
                        ),
                        SizedBox(height: 30,),
                        ///
                      ]
                  )


              )
          )
      );

  }


}