

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrm/login.dart';
import 'package:flutter_hrm/pageTransition.dart';
import 'package:flutter_hrm/personal_info_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class initialize_page extends StatefulWidget {

  @override
  _initialize_page createState()=>_initialize_page();
}

class _initialize_page extends State<initialize_page>
{

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final userNameCtr=TextEditingController();
  final userPwdCtr=TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState(){
   // final api_domain=await _getSharedPref();
   // _getSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return(
      MaterialApp(
          home:Builder (
            builder: (context) =>
                Scaffold(
                    key:_scaffoldKey,
                    body:
                    Container(
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
                                                hintText: 'Your company\'s HR domain',
                                                hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
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
                                          alignment: Alignment.bottomLeft,
                                          child:
                                          ButtonTheme(
                                              minWidth: double.infinity,
                                              padding: EdgeInsets.all(10.0),
                                              child:RaisedButton(
                                                child: Text('Continue',style: TextStyle(fontSize: 20,color: Colors.white)),
                                                splashColor: Colors.blueAccent,
                                                onPressed: () async{
                                                  _scaffoldKey.currentState.showSnackBar(
                                                      new SnackBar(duration: new Duration(seconds: 4),
                                                        content:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircularProgressIndicator(),
                                                            new Text("  Please wait....")
                                                          ],
                                                        ),
                                                      ));
                                                  //  submit_request().whenComplete(() => Navigator.of(context).pushNamed("/Home"));
                                                 bool res=await _getCompanyInfo();
                                                 // var res='';
                                                  //print (res);
                                                  if (res==true){
                                                    Navigator.push(context, pageTransition().createRoute(Login()));

                                                  }else
                                                  {
                                                    _scaffoldKey.currentState.showSnackBar(
                                                        new SnackBar(duration: new Duration(seconds: 4),
                                                          content:
                                                          new Row(
                                                            children: <Widget>[
                                                              new Icon(Icons.error,color:Colors.red),
                                                              new Text("No company matches found")
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
      )
    );
  }

   _getSharedPref() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String api_domain=prefs.getString('api_domain');

     if (api_domain != null || api_domain!="")
       {
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => new Login()),
         );
       }

    }

  _getCompanyInfo() async {
    bool res=false;
    var response = await http.post(
        Uri.encodeFull("https://hrm.islandroutes.com:8090/api/initialize/"),
        body: {
          "api_domain": userNameCtr.text,
        });
    var result=jsonDecode(response.body);

    if (response.statusCode == 200)
    {
      res=true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('company_name', result['company_name']);
      prefs.setString('api_endpoint', result['api_endpoint']);
      prefs.setString('api_domain', result['api_domain']);
    } else {
      // print (response.body);
    }
    return res;
  }

}