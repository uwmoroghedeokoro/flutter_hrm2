import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hrm/employee.dart';
import 'package:flutter_hrm/leave_status.dart';
import 'package:flutter_hrm/request_leave.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'message_note.dart';
import 'HexColor.dart';
import 'leave_entitlement.dart';

class notifications_page extends StatefulWidget{
   employee emp;
   notifications_page({this.emp});

  @override
  State<StatefulWidget> createState() {
     return notifications_home();
  }


}

class notifications_home extends  State<notifications_page>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.blue,
        title: Text(
          'Notifications'
        ),

      ),
        body: Container(
          padding: EdgeInsets.all(0),
          color: HexColor("#F7F8FE"),
          child: FutureBuilder(
            future: _getTrails(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return createListView(context, snapshot);
              }
            }
          )
        )
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
   // List<String> values = snapshot.data;
    return new ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        message_note this_trail=snapshot.data[index];
        return new
        Container(
          padding: EdgeInsets.all(15),
           margin: EdgeInsets.only(bottom: 10),
           color: Colors.white,
           child:
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
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                        //  shape: BoxShape.circle,color:Colors.blueGrey,
                          image: new DecorationImage(
                            image: new AssetImage('images/defpic.png'),
                            fit: BoxFit.cover,
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
              Text(this_trail.postedMessage,style:TextStyle(color:Colors.black87,fontSize: 15)),
            ]
        )
        );
      },
    );
  }

  Future<List<message_note>> _getTrails() async {
    var response = await http.get(
        Uri.encodeFull("http://63.143.64.98:8090/api/get_trail/"+ widget.emp.recid.toString()),
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

      // print ('data length ' + data.length.toString());
      print(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // print (my_entitements.length);
      throw Exception('Failed to load album');
    }


    //print(data[1]["title"]);

    return my_trails;
  }
}