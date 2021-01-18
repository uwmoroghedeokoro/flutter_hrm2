


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrm/employee.dart';

import 'HexColor.dart';

class personal_info_page extends StatelessWidget {
  employee myEmp;
  bool vis=false;
  personal_info_page({this.myEmp,this.vis});
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
                      Text('Personal Information',style:TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.normal)),
                    ]
                ),
              ),
              SizedBox(height: 30,),
              ///
              Expanded(
                  flex: 3,
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

                      ],
                    ).toList(),
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