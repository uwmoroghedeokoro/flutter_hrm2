import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hrm/employee.dart';
import 'package:flutter_hrm/leave_status.dart';
import 'package:flutter_hrm/name_value_object.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'HexColor.dart';
import 'leave_entitlement.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



class requestPage extends StatefulWidget {
  employee myEmp;
  requestPage({this.myEmp});

  @override
  _leave_request createState() => new _leave_request();
}

class _leave_request extends State<requestPage> {

  name_value_object selected_leave_type;
  List<name_value_object> leave_types=[];//  [name_value_object(name:'Leave 1',value: 1),name_value_object(name:'Leave 2',value: 2)];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState(){
    //configLoading();
    this.getData();

  }

  List<String> all_selected_days=[];
  //name_value_object
  final TextEditingController _leave_reason=new TextEditingController();
  //final Color bgColor=HexColor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Request Leave'),
      ),
      body: Container(
          width: double.infinity,
          color: HexColor("#F7F8FE"),  //Colors.blue[50],
          padding: EdgeInsets.all(30.0),
          child: Column(
            // runSpacing: 18,
            children: [
              Card(
                  elevation: 6,
                  shadowColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Container (
                    width: double.infinity,
                    padding: EdgeInsets.all(14),
                    child:DropdownButton<name_value_object>(
                        hint:Text('Select Leave Type'),
                        value:selected_leave_type,
                        onChanged: (name_value_object Item){
                          setState(() {
                            selected_leave_type=Item;
                            print (Item.name.toString());
                          });

                        },
                        items: leave_types.map((name_value_object leaveT){

                          return DropdownMenuItem<name_value_object>(
                              value: leaveT,
                              child: Text(leaveT.name,style:TextStyle())
                          );
                        }).toList()
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child:
                      Card(
                          elevation: 6,
                          shadowColor: Colors.grey[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child:
                          GestureDetector(
                              onTap: ()=> _selectDate(context),
                              child:
                              Container(
                                padding: EdgeInsets.all(14.0),
                                width: double.infinity,
                                // decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                                child:
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today_outlined,color: Colors.indigoAccent,),
                                    SizedBox(width: 10,)
                                    ,Text('+ Add Requested Days',style:TextStyle(color: Colors.indigoAccent,fontWeight: FontWeight.bold))
                                  ],
                                ),
                              )
                          )
                      )
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Card(
                  elevation: 6,
                  shadowColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child:
                  Container (
                    width: double.infinity,
                    padding: EdgeInsets.all(14),
                    child:
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Requested Days',style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Colors.blueGrey)),
                          new ListView.builder(
                              shrinkWrap: true,
                              padding: const  EdgeInsets.only(top:18.0,left:8.0,right:8.0,bottom: 0.0),
                              itemCount: all_selected_days==null? 0: all_selected_days.length,
                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                    padding: EdgeInsets.only(top:1.0,left:0.0,right:20.0,bottom: 10.0),
                                    child:
                                    GestureDetector(
                                        onTap: ()=> _removeDate(index),
                                        child:
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(color:Colors.blueGrey[50]),
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                            child: Row (
                                              children: [
                                                Icon(Icons.remove_circle_sharp,color:Colors.red[600]),
                                                SizedBox(width:10),
                                                Text(all_selected_days[index],style:TextStyle(fontWeight: FontWeight.bold))
                                              ],
                                            )
                                        )
                                    )
                                );
                              }

                          )
                        ]
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Card(
                  elevation: 6,
                  shadowColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child:Container(
                      padding: EdgeInsets.all(14.0),
                      width: double.infinity,
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reason',style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Colors.blueGrey)),
                            TextFormField(
                              controller: _leave_reason,)
                          ]
                      )
                  )
              ),
              SizedBox(height: 20,),
              ButtonTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  minWidth: double.infinity,
                  padding: EdgeInsets.all(10.0),splashColor: Colors.indigoAccent,
                  child:RaisedButton(
                    elevation: 6,
                    child: Container(padding:EdgeInsets.all(5.0),child:Text('Submit Request',style: TextStyle(fontSize: 15,color: Colors.white))),
                    color: Colors.indigoAccent,
                    onPressed: () async {
                      if (_all_good()) {
                        _scaffoldKey.currentState.showSnackBar(
                            new SnackBar( //duration: new Duration(seconds: 4),
                              content:
                              new Row(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  new Text("  Sending Leave Request")
                                ],
                              ),
                            ));
                        //  submit_request().whenComplete(() => Navigator.of(context).pushNamed("/Home"));
                        bool res = await submit_request();
                        if (res == true) {
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=> main_dash(thisEmp: res)));
                          Navigator.pop(context);
                        }
                      }else
                      {
                        _scaffoldKey.currentState.showSnackBar(
                            new SnackBar(//duration: new Duration(seconds: 4),
                              content:
                              new Row(
                                children: <Widget>[
                                  new Icon(Icons.error,color:Colors.red),
                                  new Text("  No days have been selected")
                                ],
                              ),
                            ));
                      }
                    },

                  )
              )
            ],
          )
      ),

    );
  }

  bool _all_good()
  {
    bool ag=true;
    if (all_selected_days.length==0) ag=false;

    return ag;
  }

  DateTime selectedDate = DateTime.now();

  _removeDate(int index)
  {
    setState(() {
      all_selected_days.removeAt(index);
    });
  }


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
        selectedDate = picked;all_selected_days.add(DateFormat('MM/dd/yyyy').format(picked));
      });
  }

  Future<bool> submit_request() async {
    bool res=false;
    String sel_dates='';

    for (String sd in all_selected_days)
    {
      sel_dates += sd +',';
    }
    sel_dates=sel_dates.substring(0, sel_dates.length - 1);

    print (widget.myEmp.recid.toString());
    print (selected_leave_type.value.toString());
    print (sel_dates);

    var response = await http.post(
        Uri.encodeFull("http://63.143.64.98:8090/api/team_status/"),

        body: {
          'empid': widget.myEmp.recid.toString(),
          'comment': _leave_reason.text,
          'leave_type':selected_leave_type.value.toString(),
          'sel_dates': sel_dates

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

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://63.143.64.98:8090/api/leave_types"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          for(Map i in data){
            name_value_object leave_type=name_value_object(name:i['leave_type'].toString(),value:i['leave_id']);
            leave_types.add(leave_type);
            print (i);
          }
          // loading = false;
        });

        print(data[0]);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        throw Exception('Failed to load album');
      }
    });

    //print(data[1]["title"]);

    return "Success!";
  }

}