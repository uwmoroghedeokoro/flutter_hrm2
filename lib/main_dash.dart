

import 'dart:convert';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hrm/employee.dart';
import 'package:flutter_hrm/employment_info_page.dart';
import 'package:flutter_hrm/leave_tab.dart';
import 'package:flutter_hrm/message_note.dart';
import 'package:flutter_hrm/notifications_page.dart';
import 'package:flutter_hrm/personal_info_page.dart';
import 'package:flutter_hrm/salary_info_page.dart';
import 'package:flutter_hrm/shift_page.dart';
import 'package:flutter_hrm/shifts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'HexColor.dart';
import 'leave_entitlement.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.myEmp}) : super(key: key);
  final String title;
  employee myEmp;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
 // employee thisEmp;
  //Map<String, double> data = new Map();
  Map<String, double> data = {
    "-": 0,

  };

  List<Color> _colors = [
    Colors.blue,
    Colors.lightBlueAccent,
    Colors.indigo,
    Colors.indigoAccent
  ];

  @override
  void initState() {
   // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Builder(
            builder: (context) =>
                Scaffold(
                 /* appBar:
                  // AppBar(
                    backgroundColor: Colors.indigoAccent,
                      title: Text('My HR Caddy')
                  ),
                  */

                  body:
                  _getBarItemWidget(_selectedDrawerIndex) ,
                  drawer: Drawer(),
                  bottomNavigationBar: FancyBottomNavigation(
                    tabs: [
                      TabData(iconData: Icons.account_circle, title: "Profile"),
                      TabData(iconData: Icons.airplanemode_active_rounded,
                          title: "Leaves"),
                      TabData(iconData: Icons.calendar_today, title: "Shifts"),
                      TabData(iconData: Icons.article_rounded, title: "Notifications")
                    ],
                    onTabChangedListener: (position) {
                      setState(() {
                        _getBarItemWidget(position);
                      });


                    },
                  ),
                )
        )
    );
  }

  _getBarItemWidget(int pos) {
    print ('tab change to ' + widget.myEmp.recid.toString());
    _selectedDrawerIndex=pos;
    switch (pos) {
      case 0:
       // print (m);
        return new_main(); //_myListView(context);
      case 1:
        return LeaveTab(myEmp: widget.myEmp);
      case 2:
      //if(!personal_info_page(myEmp: widget.myEmp).vis) personal_info_page(myEmp: widget.myEmp).vis=true; else personal_info_page(myEmp: widget.myEmp).vis=true;
        return shift_page(myEmp: widget.myEmp);
      case 3:
        //if(!personal_info_page(myEmp: widget.myEmp).vis) personal_info_page(myEmp: widget.myEmp).vis=true; else personal_info_page(myEmp: widget.myEmp).vis=true;
        return notifications_page(emp: widget.myEmp);
      case 5:
        return employment_info_page(myEmp: widget.myEmp,vis:true);
      case 6:
        return salary_info_page(myEmp: widget.myEmp,vis:true);
    }

  }
  List<leave_entitlement> my_entitements=[];
  List<shifts> my_shifts=[];

  Future<shifts> _getShifts() async {
    var response = await http.get(
        Uri.encodeFull("http://63.143.64.98:8090/api/shifts/"+ widget.myEmp.recid.toString()),
        headers: {
          "Accept": "application/json"
        }
    );
   shifts m_shift=shifts();
   if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

          for(Map i in data){
            my_shifts.add(shifts.fromJson(i));
          }
          // loading = false;
        m_shift=my_shifts[0];

        // print ('data length ' + data.length.toString());
        print(data);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        // print (my_entitements.length);
        throw Exception('Failed to load album');
      }


    //print(data[1]["title"]);

    return m_shift;
  }
  Future<message_note> _getTrails() async {
    var response = await http.get(
        Uri.encodeFull("http://63.143.64.98:8090/api/get_trail/"+ widget.myEmp.recid.toString()),
        headers: {
          "Accept": "application/json"
        }
    );
    List<message_note> my_trails=[];
    message_note a_trail=message_note();

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for(Map i in data){
        my_trails.add(message_note.fromJson(i));
      }
      // loading = false;
      if (my_trails.length>0)
           a_trail=my_trails[0];else
             {
               a_trail.postID=-1;
             }

      // print ('data length ' + data.length.toString());
      print(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // print (my_entitements.length);
      throw Exception('Failed to load album');
    }


    //print(data[1]["title"]);

    return a_trail;
  }
  _getData() async {
    var response = await http.get(
        Uri.encodeFull("http://63.143.64.98:8090/api/entitlement/"+ widget.myEmp.recid.toString()),
        headers: {
          "Accept": "application/json"
        }
    );

   // this.setState(() {

      if (response.statusCode == 200) {
        final dataz = jsonDecode(response.body);
        //setState(() {
          data.clear();
          for(Map i in dataz){
           // my_entitements.add(leave_entitlement.fromJson(i));

            data.addAll({
              i['leave_type']: i['balance'],

            });
          }
          // loading = false;
      //  });
       // print ('data length ' + data.length.toString());
        print(dataz);
      }
   // });

    //print(data[1]["title"]);

    return data;
  }

Widget new_main()
{
  return (
    Scaffold(
      body:
             Container(
                padding:EdgeInsets.all(20),
                 decoration: BoxDecoration(
                     color: Colors.grey[50] //HexColor("#F7F8FE")
                 ),
                 child:

                 Builder(
                     builder: (context) =>
                 ListView(
                     children: [
                       Container(
                           child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children:[
                                 Text('Company Name', style:TextStyle(color:Colors.black54,fontSize: 15)),
                                 Text('Summary', style:TextStyle(color:Colors.black87,fontSize: 35,fontWeight:FontWeight.bold)),
                                 SizedBox(height:26)
                               ]
                           )
                       ),
                       Card(
                         color:Colors.white,
                          elevation: 2,
                        shadowColor: Colors.grey[50],
                        child:

                        Container(
                           padding: EdgeInsets.all(15),
                           color:Colors.white,
                           child:Row(
                               children:[
                                 Container(

                                   margin: EdgeInsets.only(
                                       top: 0.0, bottom: 0.0),
                                   width: 70, height: 70,
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle,color:Colors.indigoAccent,border:Border.all(width: 4,color: Colors.blue,),
                                       image: DecorationImage(
                                           fit: BoxFit.fill,
                                         image: new AssetImage('images/defpic.png'),
                                       )
                                   ),

                                 ),
                                 Container(
                                     margin: EdgeInsets.only(left:15),
                                     child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children:[
                                           Text(widget.myEmp.fname + ' ' +
                                               widget.myEmp.lname, style: TextStyle(
                                               color: Colors.black87,
                                               fontSize: 15,
                                               fontWeight: FontWeight.bold),),
                                           Text(widget.myEmp.jobTitle, style: TextStyle(
                                               color: Colors.black54,
                                               fontSize: 13,
                                               fontWeight: FontWeight.normal),),
                                           Text(widget.myEmp.department, style: TextStyle(
                                               color: Colors.black54,
                                               fontSize: 13,
                                               fontWeight: FontWeight.normal),),
                                         ]
                                     )
                                 )
                               ]
                           ),
                         ),


                       ),


                       SizedBox(height: 14,),

                    Card(
                        color:Colors.white,
                        elevation: 2,
                        shadowColor: Colors.grey[50],
                    child: Container(
                      //height:80,
                      padding:EdgeInsets.all(10),
                      child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(
                           children: [
                             Icon(Icons.card_travel_sharp,color:Colors.amber),
                             Text(' LEAVE BALANCES',style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize:15)),
                      ]
                          ),
                            SizedBox(height: 10,),
                      FutureBuilder(
                          future: _getData(),
                        builder: (BuildContext context,AsyncSnapshot snapshot){
                          if(snapshot.connectionState == ConnectionState.done)
                            return new
                            PieChart(
                              chartType: ChartType.ring,
                              chartLegendSpacing: 52,
                              animationDuration: Duration(milliseconds: 800),
                              colorList:_colors,
                              chartRadius: MediaQuery.of(context).size.width / 5.2,
                              initialAngleInDegree: 0,
                              ringStrokeWidth: 22,
                              dataMap: snapshot.data,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValueBackground: false,
                                showChartValues: false,
                                showChartValuesInPercentage: false,
                                // showChartValuesOutside: true,
                              ),
                            );
                          else
                            return Center(child: CircularProgressIndicator());
                        }

                      )

                        ]
                      )
                    )
                  ),
                       SizedBox(height: 10,),
                       Card(
                           color:Colors.white,
                           elevation: 2,
                           shadowColor: Colors.grey[50],
                           child: Container(
                             //height:80,
                               padding:EdgeInsets.all(10),
                               child:
                               FutureBuilder<shifts>(
                                   future: _getShifts(),
                                   builder: (BuildContext context,AsyncSnapshot snapshot){
                                     shifts mShift=snapshot.data;
                                     if(snapshot.connectionState == ConnectionState.done)
                                       return new
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                               children: [
                                                 Icon(Icons.timelapse_rounded,color:Colors.green),
                                                 Text(' YOUR SHIFTS',style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize:15)),
                                               ]
                                           ),
                                           SizedBox(height: 10,),
                                           Row(
                                             children: [
                                               //shift date
                                               Row(
                                                 children: [
                                                   Text(DateFormat('dd').format(DateTime.now()),style:TextStyle(color:Colors.blue,fontSize: 40)),
                                                   Column(
                                                     children: [
                                                       Text(DateFormat('EEE').format(DateTime.now()).toUpperCase(),style:TextStyle(color:Colors.grey,fontSize:13,fontWeight:FontWeight.bold)),
                                                       Text(DateFormat('MMM').format(DateTime.now()).toUpperCase(),style:TextStyle(color:Colors.blue,fontSize:15,fontWeight:FontWeight.bold))
                                                     ],
                                                   ),

                                                   SizedBox(width: 30,),
                                                   Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Text(mShift.start + ' - ' + mShift.end,style:TextStyle(color:Colors.black54,fontSize:20,fontWeight:FontWeight.bold)),
                                                       Text(mShift.name,style:TextStyle(color:Colors.black54,fontSize:16,fontWeight:FontWeight.normal)),
                                                     ],
                                                   )
                                                 ],
                                               ),


                                             ],
                                           ),
                                           SizedBox(height: 30,),
                                           Divider(
                                             indent: 40,
                                             endIndent: 40,
                                             color:Colors.blue[50],
                                             thickness: 1,
                                             height: 3,
                                           ),
                                           Container(
                                               alignment: Alignment.center,
                                               margin: EdgeInsets.only(top:10),
                                               child:Text('VIEW WEEK\'S SHIFT',style:TextStyle(color:Colors.blue[200],fontWeight: FontWeight.bold))
                                           )
                                         ],

                                       );
                                     else
                                       return Center(child: CircularProgressIndicator());
                                   }

                               )

                           )
                       ),
                       SizedBox(height: 10,),
                       Card(
                           color:Colors.white,
                           elevation: 2,
                           shadowColor: Colors.grey[50],
                           child: Container(
                             //height:80,
                               padding:EdgeInsets.all(10),
                               child:
                               FutureBuilder<message_note>(
                                   future: _getTrails(),
                                   builder: (BuildContext context,AsyncSnapshot snapshot){
                                     message_note this_trail=snapshot.data;
                                     if(snapshot.connectionState == ConnectionState.done)
                                       return new
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                               children: [
                                                 Icon(Icons.stars_sharp,color:Colors.blue),
                                                 Text(' LATEST NOTIFICATION',style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize:15)),
                                               ]
                                           ),
                                           SizedBox(height: 10,),
                                          if (this_trail.postID>-1)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               //shift date
                                               Row(
                                                 children: [
                                                   Container(

                                                     margin: EdgeInsets.only(
                                                         top: 0.0, bottom: 0.0),
                                                     width: 30, height: 30,
                                                     decoration: BoxDecoration(
                                                        // shape: BoxShape.circle,color:Colors.blueGrey,
                                                       image: new DecorationImage(
                                                         image: new AssetImage('images/defpic.png')
                                                       )
                                                     ),

                                                   ),
                                                   SizedBox(width:7),
                                                   Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Text(this_trail.postID>-1?this_trail.postedBy: 'Sender Name',style:TextStyle(color:Colors.black87,fontSize:13,fontWeight:FontWeight.bold)),
                                                       Text(this_trail.postedOn,style:TextStyle(color:Colors.grey,fontSize:12,fontWeight:FontWeight.normal))
                                                     ],
                                                   ),


                                                 ],
                                               ),


                                             ],
                                           ),
                                           SizedBox(height: 10,),
                                           Text(this_trail.postedMessage,style:TextStyle(color:Colors.black54,fontSize: 14)),
                                              if (this_trail.postedDoc.contains('.pdf'))
                                                Container(
                                                    padding: const EdgeInsets.all(5.0),
                                                    margin: const EdgeInsets.only(top:15),
                                                    // color:Colors.grey[100],
                                                    decoration: BoxDecoration(
                                                        color:Colors.grey[100],
                                                        borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                                                        border:  Border.all(color:Colors.black12)
                                                    ),
                                                    child:
                                                    GestureDetector(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> view_pdf(pdf_path: this_trail.postedDoc)));
                                                        },
                                                        child:
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 18.0,
                                                              backgroundImage:
                                                              AssetImage('images/pdficon.png'),
                                                              backgroundColor: Colors.red,
                                                            ),
                                                            Text(' View Attachment',style: TextStyle(fontSize: 14,color:Colors.black54,fontWeight: FontWeight.bold),)
                                                          ],
                                                        )
                                                    )
                                                )
                                              else if(this_trail.postedDoc.contains('.png' ) || this_trail.postedDoc.contains('.jpg') || this_trail.postedDoc.contains('.jpeg'))
                                                Container(
                                                    width:double.infinity,
                                                    // margin:EdgeInsets.only(top:10),
                                                    padding: const EdgeInsets.all(3.0),
                                                    margin: const EdgeInsets.only(top:15),
                                                    decoration: BoxDecoration(
                                                        borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                                                        border:  Border.all(color:Colors.black12)
                                                    ),
                                                    child:
                                                    Image.network('http://63.143.64.98:8070/sharePhotos/' + this_trail.postedDoc)
                                                )
                                     ]
                                     )
                                           else
                                            Column(
                                                children:[
                                                  Row(
                                                    children: [
                                                      //shift date


                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Text('No notifications',style:TextStyle(color:Colors.black54,fontSize: 14)),
                                                ]
                                            ),
                                           SizedBox(height: 30,),
                                           Divider(
                                             indent: 40,
                                             endIndent: 40,
                                             color:Colors.blue[50],
                                             thickness: 1,
                                             height: 3,
                                           ),
                                           Container(
                                               alignment: Alignment.center,
                                               margin: EdgeInsets.only(top:10),
                                               child:Text('VIEW ALL NOTIFICATIONS',style:TextStyle(color:Colors.blue[200],fontWeight: FontWeight.bold))
                                           )
                                         ],

                                       );
                                     else
                                       return Center(child: CircularProgressIndicator());
                                   }

                               )

                           )
                       )
                     ]
                 )
                 )


                     )
             )


  );

}

  Widget _profile_main()
  {
    return  Container(
      decoration: BoxDecoration(
          color: Colors.indigoAccent
      ),
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                        ),
                        width: double.infinity, height: 300,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center,
                            children: [
                              //  Image.network("https://www.hashatit.com/images/uploads/users/61602/profile_picture/3F6B966D00000578-4428630-image-m-80_1492690622006.jpg",width: 100,height: 100),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 20.0, bottom: 10.0),
                                width: 130, height: 130,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            "images/prof.jpg")
                                    )
                                ),

                              ),
                              Text(widget.myEmp.fname + ' ' +
                                  widget.myEmp.lname, style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),),
                              Container(
                                padding: EdgeInsets.all(4.0),
                                child: Text(widget.myEmp.jobTitle,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight
                                          .normal),),
                              ),
                              Container(
                                child: Text(widget.myEmp.department,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight
                                          .normal),),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 20),
                                  child: Center(
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets
                                                  .only(
                                                  right: 5.0),
                                              child: Icon(Icons
                                                  .gps_fixed_rounded,
                                                color: Colors
                                                    .white,),
                                            ),
                                            Text(
                                              widget.myEmp.eLocation +
                                                  ', ',
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .bold),),
                                            Container(
                                              child: Text(
                                                widget.myEmp.eCountry,
                                                style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .bold),),
                                            )

                                          ]

                                      )
                                  )
                              )
                            ]
                        )
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Container( // bottom layout
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0))
                      ),
                      width: double.infinity,
                      child: Container(
                          child: Builder(
                            builder: (context) =>
                                _myListView(context),

                          )

                      ),
                    )
                )
              ]
          )
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.contacts_rounded, size: 30,),
            title: Text('Personal Information',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('View your personal details.'),
            trailing: Icon(Icons.keyboard_arrow_right),
             onTap: (){
              print ('tapped');
              setState(() {
                _getBarItemWidget(4);
              });
              },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.psychology_rounded, size: 30),
            title: Text('Employment Details',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('View your job details'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              print ('tapped');
              setState(() {
                _getBarItemWidget(5);
              });
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
            leading: Icon(Icons.monetization_on_rounded, size: 30),
            title: Text('Salary Information',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('See your salary details, etc '),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              print ('tapped');
              setState(() {
                _getBarItemWidget(6);
              });
            },
          ),
        ],
      ).toList(),
    );
  }


  Widget bodyWidget;






  int _selectedDrawerIndex = 0;


}



class main_dash extends StatelessWidget {
  employee thisEmp;

  main_dash({this.thisEmp});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home:MyHomePage(title:'e',myEmp: thisEmp,)
    );
  }



}

