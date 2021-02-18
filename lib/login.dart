
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hrm/company_info.dart';
import 'package:flutter_hrm/employee.dart';
import 'package:flutter_hrm/forgotPassword.dart';
import 'package:flutter_hrm/main_dash.dart';
import 'package:flutter_hrm/pageTransition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class Login extends StatefulWidget{


  @override
  _Login createState()=>_Login();
}

class _Login extends State<Login>{

  final userNameCtr=TextEditingController();
  final userPwdCtr=TextEditingController();



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return
     MaterialApp(
     home:Builder (
       builder: (context) =>
     Scaffold(
       key:_scaffoldKey,
       body:
       Container(
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
                   Text('Mango HR',style:TextStyle(fontSize: 30.0,color: Colors.lightBlue,fontWeight: FontWeight.bold)),
                    SizedBox(height: 30),
                    Text(companyIfo.company_name==null?'-':companyIfo.company_name,style:TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold))
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
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> main_dash()), (Route<dynamic> route) => false);

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
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(pageTransition().createRoute(forgotPassword()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left:10,top:10),
                        child: Text('Forgot password?',style:TextStyle(fontSize:15,color:Colors.blue,fontWeight:FontWeight.bold))
                      )
                    )
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

  @override
  void initState(){

    companyIfo.company_name='-';

    setState(() {
      //companyIfo.company_name='NOT BLANK';
     getStringValuesSF();
    });
  }

  company_info companyIfo=company_info();
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
       companyIfo.company_name=prefs.getString('company_name');
       companyIfo.api_domain=prefs.getString('api_domain');
       companyIfo.api_endpoint=prefs.getString('api_endpoint');
    });

    print('de - ' + prefs.getString('company_name'));

    return companyIfo;
  }

  Future<employee> log_me_in() async {
    employee emp=employee();
    final response = await http.get(companyIfo.api_endpoint + '/api/login/' + userNameCtr.text + '/'+ userPwdCtr.text);
    bool res=false;

    print (response);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      emp= employee.fromJson(jsonDecode(response.body));
      prefs.setInt('empid', emp.recid);

    //  Map<String,dynamic> empMap = employee().toMap();
    //  await prefs.setString('empMap', json.encode(empMap));

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