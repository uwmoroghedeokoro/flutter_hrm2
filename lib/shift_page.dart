

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrm/employee.dart';
import 'package:flutter_hrm/shifts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'HexColor.dart';
import 'company_info.dart';
class shift_page extends StatefulWidget{

  employee myEmp;
  shift_page({this.myEmp});

  @override
  _my_shift_page createState() => new _my_shift_page();

}





class _my_shift_page extends State<shift_page> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return   (
    Scaffold(
      appBar: _tab_bar(),
      body: TabBarView(
        children: [
          myShift_page(),
          teamShift_page(),
        ],
        controller: _tabController,
      ),

    )
    );

  }

  TabController _tabController;
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async
  {

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        team_shifts=[];
        selectedDate = picked;
        getTeamData();
      });
  }

  Widget myShift_page() {
    return (
        Scaffold(
        body: Container(
        color:HexColor("#F7F8FE"),
    child:
        Container(
          color:HexColor("#F7F8FE"),
          child:
          new ListView.builder(
            padding: const EdgeInsets.all(8),

            itemCount: my_shifts==null? 0: my_shifts.length,
            itemBuilder: (BuildContext context, int index){
              return new Card(
                  child: Container(
                      padding: EdgeInsets.only(top:15.0,left:20.0,right:20.0,bottom: 15.0),
                      child: Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Text(my_shifts[index].date,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent,fontSize: 16)),
                          SizedBox(height: 7),
                          Row(
                              children: [
                                Expanded(
                                    flex:3,
                                    child:
                                    Container(
                                        width: double.infinity,
                                        child: Column(
                                            children:[
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(my_shifts[index].name,style: TextStyle(fontSize:25.0,color: Colors.black,fontWeight: FontWeight.bold ),),



                                                ],
                                              ),
                                              Divider(
                                                color: Colors.grey[150],
                                                height: 20,
                                                thickness: 1,
                                                indent: 0,
                                                endIndent: 0,
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 60,
                                                    child:Text(my_shifts[index].start,style: TextStyle(fontSize:17.0,color: Colors.black54,fontWeight: FontWeight.bold ),),
                                                  ),
                                                  Text('Starts',style: TextStyle(fontSize:13.0,color: Colors.grey,fontWeight: FontWeight.bold ),),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 60,
                                                    child:Text(my_shifts[index].end,style: TextStyle(fontSize:15.0,color: Colors.black54,fontWeight: FontWeight.bold ),),
                                                  ),
                                                  Text('Ends',style: TextStyle(fontSize:12.0,color: Colors.grey,fontWeight: FontWeight.bold ),),


                                                ],
                                              ),
                                            ]
                                        )
                                    )
                                ),
                                Expanded(
                                    flex: 1,
                                    child:
                                    Container(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.watch_later_sharp,size:60,color: HexColor(my_shifts[index].color),)
                                    )
                                )

                              ]
                          )
                        ],
                      )

                  )
              );
            },
          ),
        )
        )
        )
    );
  }

  Widget teamShift_page()
  {
      return (
          Scaffold(
          body:
          Container(
              color:HexColor("#F7F8FE"),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  GestureDetector(
                  onTap: ()=> _selectDate(context),
              child:
                    Container(
                        padding: EdgeInsets.all(20),
                      color:Colors.blueGrey[600],
                      child:
                        Row(
                          children: [
                            Icon(Icons.calendar_today,size: 20,color:Colors.white), Text ('  Select Day',style:TextStyle(fontSize: 20,color: Colors.white)),
                            Expanded(
                                flex: 1,
                                child:
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.keyboard_arrow_right,size:30,color: HexColor("#ffffff"),)
                                )
                            )
                          ],
                        )

                    )
                  ),
                    Container(
                      padding: EdgeInsets.all(10),child: Text(DateFormat('MMM dd, yyyy').format(selectedDate),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color:Colors.black54),),
                    ),
                    Expanded(
                      child:
                    new ListView.builder(
                      padding: const EdgeInsets.all(0),

                      itemCount: team_shifts==null? 0: team_shifts.length,
                      itemBuilder: (BuildContext context, int index){
                        return new
                            Container(
                                padding: EdgeInsets.only(top:5.0,left:20.0,right:20.0,bottom: 0.0),
                                color:Colors.white,
                                child:
                                Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [

                                       SizedBox(
                                         width:40,
                                child:
                                    Container(
                                          child: Column(
                                            children:[
                                              Text(team_shifts[index].start,style:TextStyle(fontWeight: FontWeight.bold, color:Colors.grey)),
                                              Text(team_shifts[index].end,style:TextStyle(fontWeight: FontWeight.bold, color:Colors.grey)),
                                            ]
                                          ),
                                        )
                                       ),
                                        Container(color: Colors.blueGrey, height: 37, width: 2,margin: EdgeInsets.only(left: 10,right:10),),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                            Text(team_shifts[index].emp_name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontSize: 16)),
                                            Text(team_shifts[index].name,style: TextStyle(fontWeight: FontWeight.bold,color: HexColor(team_shifts[index].color),fontSize: 15))
                                          ]
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child:
                                            Container(
                                                alignment: Alignment.centerRight,
                                                child: Icon(Icons.watch_later_sharp,size:30,color: HexColor(team_shifts[index].color),)
                                            )
                                        )
                                      ],
                                    ),
                                    Divider()

                                  ],
                                )

                            );

                      },
                    ),
                    )
                  ]
              )
          )
          )
      );

  }

  Widget _tab_bar()
  {
    return AppBar(
        backgroundColor: Colors.indigoAccent,
        toolbarHeight: 50,
        flexibleSpace: SafeArea(
            child:TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.white,

              tabs: [
                Tab(
                  child: Text("My Schedule"),
                ),
                Tab(
                  child: Text("Team Schedule"),
                ),

              ],

              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
            )
        )
    )
    ;
  }


  List<shifts> my_shifts=[];
  List<shifts> team_shifts=[];

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(companyIfo.api_endpoint+ "/api/shifts/"+ widget.myEmp.recid.toString()),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          for(Map i in data){
            my_shifts.add(shifts.fromJson(i));
          }
          // loading = false;
        });
       // print ('data length ' + data.length.toString());
        print(data);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
       // print (my_entitements.length);
        throw Exception('Failed to load album');
      }
    });

    //print(data[1]["title"]);

    return "Success!";
  }
  Future<String> getTeamData() async {
    var response = await http.get(
        Uri.encodeFull(companyIfo.api_endpoint+ "/api/team_shifts/" + DateFormat('MM-dd-yyyy').format(selectedDate) + "/" + widget.myEmp.recid.toString()),
        headers: {
          "Accept": "application/json"
        }
    );
//print ("http://63.143.64.98:8090/api/team_shifts/" + DateFormat('MM-dd-yyyy').format(selectedDate) + "/" + widget.myEmp.recid.toString());
    this.setState(() {

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          for(Map i in data){
            team_shifts.add(shifts.fromJson(i));
          }
          // loading = false;
        });
        // print ('data length ' + data.length.toString());
        print(data);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        // print (my_entitements.length);
        print(response.body);
        throw Exception('Failed to load album');
      }
    });

    //print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState(){
    _tabController = TabController(length: 2,vsync: this);
    anotherfunc();
  }

  anotherfunc() async
  {
    final awa=await getStringValuesSF();
    print ("fin");
    this.getData();

    team_shifts=[];
    selectedDate = DateTime.now();
    getTeamData();
  }

  company_info companyIfo=company_info();
  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      companyIfo.company_name=prefs.getString('company_name');
      companyIfo.api_domain=prefs.getString('api_domain');
      companyIfo.api_endpoint=prefs.getString('api_endpoint');
    });

    return "done";
  }

}