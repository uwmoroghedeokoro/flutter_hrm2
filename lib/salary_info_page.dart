import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrm/employee.dart';

import 'HexColor.dart';

class salary_info_page extends StatelessWidget {
  employee myEmp;
  bool vis=false;
  salary_info_page({this.myEmp,this.vis});
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
                                Text('Salary Information',style:TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.normal)),
                              ]
                          ),
                        ),

                        ///
                        Expanded(
                            flex: 3,
                            child:

                            Column(
                                children: [
                                  SizedBox(height: 30,),
                                  new ListView(
                                    controller: _controller,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,

                                    children:  ListTile.divideTiles(
                                      context: context,
                                      tiles: [
                                        ListTile(
                                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                          title: Text('Effective Date', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                          subtitle: Text(myEmp.pay_effective,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                          title: Text('Pay Grade', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                          subtitle: Text(myEmp.pay_grade,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                          title: Text('Pay Frequency', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                          subtitle: Text(myEmp.pay_freq,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                          title: Text('Currency', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                          subtitle: Text(myEmp.pay_currency,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                          title: Text('Annual Salary', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                          subtitle: Text(myEmp.pay_amount.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.only(left: 20.0, right: 30.0),
                                          title: Text('Vehicle Allowance', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0,color:Colors.blueAccent)),
                                          subtitle: Text(myEmp.pay_veh_allowance.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.black54),),
                                        ),

                                      ],
                                    ).toList(),
                                  )
                                  ,
                                /*
                                  Expanded(
                                      child:
                                      Container(
                                          margin: EdgeInsets.only(left: 20,top:30),
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
                                                            child: Text(myEmp.sups[index].sub_sup_name),
                                                          );
                                                        }
                                                    )
                                                )
                                              ]
                                          )
                                      )
                                  )


                                 */
                                ]
                            )
                        ),

                        ///
                      ]
                  )


              )
          )
      );

  }


}