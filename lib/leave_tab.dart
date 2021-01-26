import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hrm/employee.dart';
import 'package:flutter_hrm/leave_status.dart';
import 'package:flutter_hrm/request_leave.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'HexColor.dart';
import 'company_info.dart';
import 'leave_entitlement.dart';




class LeaveTab extends StatefulWidget {
  employee myEmp;
  LeaveTab({this.myEmp});

  @override
  _leave_balance createState() => new _leave_balance();
}


class _leave_balance extends State<LeaveTab> with TickerProviderStateMixin{
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<leave_entitlement> my_entitements=[];
  List<leave_status> my_status=[];
  List<leave_status> team_status=[];

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(companyIfo.api_endpoint + "/api/entitlement/"+ widget.myEmp.recid.toString()),
        headers: {
          "Accept": "application/json"
        }
    );
//print(companyIfo.api_endpoint + "/api/entitlement/"+ widget.myEmp.recid.toString());
    this.setState(() {

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          for(Map i in data){
            my_entitements.add(leave_entitlement.fromJson(i));
          }
         // loading = false;
        });
        print ('data length ' + data.length.toString());
        print(data);
       } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print (my_entitements.length);
        throw Exception('Failed to load album');
      }
  });

    //print(data[1]["title"]);

    return "Success!";
  }

  Future<String> getData_Status() async {
    var response = await http.get(
        Uri.encodeFull(companyIfo.api_endpoint+"/api/leave_status/"+ widget.myEmp.recid.toString()),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          for(Map i in data){
            my_status.add(leave_status.fromJson(i));
          }
          // loading = false;
        });
       // print ('data length ' + data.length.toString());
       // print(data);
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

  Future<String> getData_Team() async {
    var response = await http.get(
        Uri.encodeFull(companyIfo.api_endpoint + "/api/team_status/"+ widget.myEmp.recid.toString()),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          team_status=[];
          for(Map i in data){
            team_status.add(leave_status.fromJson(i));
          }
          // loading = false;
        });
        // print ('data length ' + data.length.toString());
        // print(data);
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

  @override
  void initState(){

    _tabController = TabController(length: 3,vsync: this);
    _tabController.addListener(_handleTabSelection);

    anotherfunc();

  }

  anotherfunc() async
  {
    final awa=await getStringValuesSF();
    print ("fin");
      this.getData();
     this.getData_Status();
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


  _handleTabSelection() {
    setState(() {
      if (_tabController.index==1){
        this.getData_Status();
      }else if (_tabController.index==2)
        {
          this.getData_Team();
        }
      print (_tabController.index);
     // _currentIndex = _tabController.index;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return (
   Scaffold(
     appBar: leave_tab_bar(),
     body: TabBarView(
     children: [
      leave_balance_page(),
      leave_status_page(),
      team_status_page()
      ],
    controller: _tabController,
    ),
     floatingActionButton:
     FloatingActionButton(
       backgroundColor: Colors.blue,
       child: Icon(
         Icons.add
       ),
       onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> requestPage(myEmp: widget.myEmp)));
       },
     ),
   )

   );
  }

  Widget leave_balance_page()
  {
    return
      Scaffold(
      body: Container(
        color:HexColor("#F7F8FE"),
      child:
      new ListView.builder(
        padding: const EdgeInsets.all(8),

        itemCount: my_entitements==null? 0: my_entitements.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
              child: Container(
                  padding: EdgeInsets.only(top:15.0,left:20.0,right:20.0,bottom: 15.0),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(my_entitements[index].leave_type,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent,fontSize: 14)),
                      SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            child:Text(my_entitements[index].balance.toString(),style: TextStyle(fontSize:20.0,color: Colors.black,fontWeight: FontWeight.bold ),),
                          )
                          ,
                          Text('Days Available',style: TextStyle(fontSize:14.0,color: Colors.black,fontWeight: FontWeight.bold ),),


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
                            child:Text(my_entitements[index].accrued.toString(),style: TextStyle(fontSize:15.0,color: Colors.black54,fontWeight: FontWeight.bold ),),
                          ),
                          Text('Accrued so far',style: TextStyle(fontSize:12.0,color: Colors.grey,fontWeight: FontWeight.bold ),),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            child:Text(my_entitements[index].taken.toString(),style: TextStyle(fontSize:15.0,color: Colors.black54,fontWeight: FontWeight.bold ),),
                          ),
                          Text('Taken so far',style: TextStyle(fontSize:12.0,color: Colors.grey,fontWeight: FontWeight.bold ),),


                        ],
                      ),
                    ],
                  )

              )
          );
        },
      ),
      )
    );
  }

  Widget leave_status_page()
  {
    return  Scaffold(
      body: Container(
        color:HexColor("#F7F8FE"),
      child:new ListView.builder(
        padding: const  EdgeInsets.only(top:18.0,left:8.0,right:8.0,bottom: 0.0),

        itemCount: my_status==null? 0: my_status.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
                  padding: EdgeInsets.only(top:1.0,left:20.0,right:20.0,bottom: 10.0),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text('Request Type : ' + my_status[index].leave_type,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 14)),
                      SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child:Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Days Requested : ' + my_status[index].req_days.toString() ,style: TextStyle(fontSize:12.5,color: Colors.grey[500],fontWeight: FontWeight.bold ),),
                                  Text('From ' + my_status[index].start_date + ' To ' + my_status[index].return_date,style: TextStyle(fontSize:12.5,color: Colors.grey[500],fontWeight: FontWeight.bold ),),
                                  ],
                              ),
                            )
                          ),
                          Expanded(
                              flex: 1,
                              child:Container(

                              )
                          )
                          ,
                          Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: my_status[index].status=='Scheduled'? Colors.green: Colors.grey
                            ),
                            child: Text(my_status[index].status,style: TextStyle(fontSize:11.0,color: Colors.white,fontWeight: FontWeight.bold ),),
                          )


                        ],
                      ),
                      Divider(
                        color: Colors.grey[150],
                        height: 20,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),

                    ],
                  )


          );
        },
      ),
      )
    );
  }

  Widget team_status_page()
  {
    return  Scaffold(
      key: _scaffoldKey,
        body: Container(
          color:HexColor("#F7F8FE"),
          child:

             new ListView.builder(
            padding: const  EdgeInsets.only(top:18.0,left:8.0,right:8.0,bottom: 0.0),
            itemCount: team_status==null? 0: team_status.length,
            itemBuilder: (BuildContext context, int index){

              return
                Container(
                  padding: EdgeInsets.only(top:1.0,left:20.0,right:20.0,bottom: 10.0),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(team_status[index].emp_name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 14)),

                      new Text('Request Type : ' + team_status[index].leave_type,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontSize: 14)),
                      SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 4,
                              child:Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Days Requested : ' + team_status[index].req_days.toString() ,style: TextStyle(fontSize:12.5,color: Colors.grey[500],fontWeight: FontWeight.bold ),),
                                    Text('From ' + team_status[index].start_date + ' To ' + team_status[index].return_date,style: TextStyle(fontSize:12.5,color: Colors.grey[500],fontWeight: FontWeight.bold ),),
                                  ],
                                ),
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child:Container(
                                child:  ButtonTheme(
    minWidth: double.infinity,
    padding: EdgeInsets.all(10.0),
    child: RaisedButton(
      onPressed: (){
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar( //duration: new Duration(seconds: 4),
              content:
              new Row(
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Text("  Please wait.")
                ],
              ),
            ));
        submit_response(team_status[index]).then((result) {
         setState(() {
          print('done');
           this.getData_Team();
         });
        });
      },
      padding: EdgeInsets.all(7),
      splashColor: Colors.green,
      color: Colors.greenAccent,
      child: Text("Approve",style: TextStyle(fontSize:11.0,color: Colors.white,fontWeight: FontWeight.bold ),),
    )
),
                              )
                          )
                          ,


                        ],
                      ),
                      Divider(
                        color: Colors.grey[150],
                        height: 20,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),

                    ],
                  )


              );
            },
          ),



        )
    );
  }


  Future<bool> submit_response(leave_status leave_req) async {
    bool res=false;
    String sel_dates='';
print(leave_req.req_id);
    var response = await http.post(
        Uri.encodeFull(companyIfo.api_endpoint + "/api/request_response/"),

        body: {
          'empid': leave_req.emp_id.toString(),
          'userid': widget.myEmp.recid.toString(),
          'leaveid':leave_req.leave_id.toString(),
          'reqdays': leave_req.req_days.toString(),
          'nstatus': "1",
          'reqid': leave_req.req_id.toString(),
        }

    );

    if (response.statusCode == 200) {
      res=true;
      print (response.body);
      //print(response.body['myJob']['jTitle']['title']);
    } else {
      print (response.body);
    }
    return res;

  }


  TabController _tabController;
  Widget leave_tab_bar()
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
          child: Text("Balances"),
        ),
        Tab(
          child: Text("Status"),
        ),
        Tab(
          child: Text("Requests"),
        )
      ],

      controller: _tabController,
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
    )
      )
    )
    ;
  }
}