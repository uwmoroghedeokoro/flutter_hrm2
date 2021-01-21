
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hrm/employee.dart';
import 'package:flutter_hrm/main_dash.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatelessWidget{

  final userNameCtr=TextEditingController();
  final userPwdCtr=TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
     home:Builder (
       builder: (context) =>
     Scaffold(
       key:_scaffoldKey,
       body:Container(
       // decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/bg1.jpg"), fit:BoxFit.fill),),
         color: Colors.grey[50],
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
              child:Container(
                padding: EdgeInsets.all(30.0),
                alignment: Alignment.bottomCenter,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Container (
                     margin: EdgeInsets.only(bottom:30,top:20),
                       child:Image.asset("images/grp.png",height: 50,width: 50)
                   ),
                   Text('Login to', style: TextStyle(fontSize: 20.0,color: Colors.lightBlue)),
                   Text('Mango HR',style:TextStyle(fontSize: 35.0,color: Colors.lightBlue,fontWeight: FontWeight.bold))
                  ],
                ),

              )),
              Expanded(
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    padding:  EdgeInsets.all(20.0),
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.all(Radius.circular(20.0))
                ),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                       TextField(
                            textAlign: TextAlign.center,
                            controller: userNameCtr,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Enter your Employee No.',
                              hintStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: double.infinity,
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            controller: userPwdCtr,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                            //  fillColor: colorSearchBg,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.bottomLeft,
                      child:
                      ButtonTheme(
                        minWidth: double.infinity,
                        padding: EdgeInsets.all(10.0),
                      child:RaisedButton(
                        child: Text('Login',style: TextStyle(fontSize: 20,color: Colors.white)),
                        splashColor: Colors.blueAccent,
                        onPressed: () async{
                          _scaffoldKey.currentState.showSnackBar(
                              new SnackBar(duration: new Duration(seconds: 4),
                                content:
                                new Row(
                                  children: <Widget>[
                                    new CircularProgressIndicator(),
                                    new Text("  Logging In....")
                                  ],
                                ),
                              ));
                          //  submit_request().whenComplete(() => Navigator.of(context).pushNamed("/Home"));
                          employee res=await log_me_in();
                          //print (res);
                         if (res.recid>0){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> main_dash(thisEmp: res)));

                          }else
                            {
                              _scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(duration: new Duration(seconds: 4),
                                    content:
                                    new Row(
                                      children: <Widget>[
                                        new Icon(Icons.error,color:Colors.red),
                                        new Text("  Username/Password incorrect")
                                      ],
                                    ),
                                  ));
                            }
                          },

                      )
                      )
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),

       )

     ),
     )
   );
  }


  Future<employee> log_me_in() async {
    //print(userNameCtr.text);
   // return http.get('http://63.143.64.98:8090/api/login/' + userNameCtr.text + '/'+ userPwdCtr.text);
    employee emp=employee();
    final response = await http.get('http://63.143.64.98:8090/api/login/' + userNameCtr.text + '/'+ userPwdCtr.text);
    bool res=false;

    print (response);
    if (response.statusCode == 200) {
      emp= employee.fromJson(jsonDecode(response.body));
      res=true;
      print (response.body);
      //print(response.body['myJob']['jTitle']['title']);
    } else {
      emp.recid=-1;
      // If the server did not return a 200 OK response,
      // then throw an exception.

      //throw Exception('Failed to load album');
    }
   return (emp);
    // return res;
  }


}