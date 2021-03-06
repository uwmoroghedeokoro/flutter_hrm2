

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrm/department.dart';
import 'package:flutter_hrm/employee.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'HexColor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'company_info.dart';

class new_notification extends StatefulWidget {
  employee meEmp;

  new_notification({this.meEmp});

  @override
    _new_notification createState() => new _new_notification(thisEmp: meEmp);

}

class _new_notification extends State<new_notification>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _new_notification({this.thisEmp});
  employee thisEmp;
  TextEditingController _notify_message=TextEditingController();

  List<departments> departs=[]; //();
  departments selected_dept;


  @override
  void initState(){
    //configLoading();
   //print (thisEmp.depts[0].name);
     departs=thisEmp.depts;
     anotherfunc();
  }

  anotherfunc() async
  {
    final awa=await getStringValuesSF();
    print ("fin");

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
  static final String uploadEndPoint =
      'http://localhost/flutter_test/upload_image.php';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {

    setState(() {
      print('jello');
      final _picker = ImagePicker();
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;

          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            child: Image.file(snapshot.data, fit: BoxFit.fill,height: 150,),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  File _image;

  PickedFile imageFile;

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('New Notification'),
      ),

        body:

      Container(
          width: double.infinity,
          color: Colors.grey[50],  //Colors.blue[50],
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
                    child:DropdownButton<departments>(
                        hint:Text('Select Recipients'),
                        value:selected_dept,
                        onChanged: (departments Item){
                          setState(() {
                            selected_dept=Item;
                            print (Item.name.toString());
                          });

                        },
                        items: departs.map((departments dept){

                          return DropdownMenuItem<departments>(
                              value: dept,
                              child: Text(dept.name,style:TextStyle())
                          );
                        }).toList()
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
                            Text('Message',style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Colors.blueGrey)),
                            TextFormField(keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              controller: _notify_message,)
                          ]
                      )
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
                            Text('Add ttachment',style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Colors.blueGrey)),
                            OutlineButton(
                              onPressed: chooseImage,
                              child: Text('Choose Image'),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            showImage(),
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
                    child: Container(padding:EdgeInsets.all(5.0),child:Text('Send Notification',style: TextStyle(fontSize: 15,color: Colors.white))),
                    color: Colors.indigoAccent,
                    onPressed: () async {
                      {
                        if (selected_dept != null) {
                          _scaffoldKey.currentState.showSnackBar(
                              new SnackBar( //duration: new Duration(seconds: 4),
                                content:
                                new Row(
                                  children: <Widget>[
                                    new CircularProgressIndicator(),
                                    new Text("  Sending Notification")
                                  ],
                                ),
                              ));
                          // submit_request().whenComplete(() => Navigator.of(context).pushNamed("/Home"));
                          bool res = await hii('', '');
                          // Navigator.pop(context);

                          if (res == true) {
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=> main_dash(thisEmp: res)));
                            Navigator.pop(context);
                          } else
                            _scaffoldKey.currentState.showSnackBar(
                                new SnackBar( //duration: new Duration(seconds: 4),
                                  content:
                                  new Row(
                                    children: <Widget>[
                                      new Text(
                                          "An error occured. Please try again")
                                    ],
                                  ),
                                ));
                        }else {
                          _scaffoldKey.currentState.showSnackBar(
                              new SnackBar( //duration: new Duration(seconds: 4),
                                content:
                                new Row(
                                  children: <Widget>[
                                    new Text(
                                        " Please seelct a recipient group")
                                  ],
                                ),
                              ));
                        }
                      }
                    },

                  )
              )
            ],
          )
      ),



    );
  }

  hii(String filename, String url) async {
    bool res=false;
    var request = http.MultipartRequest('POST', Uri.parse(companyIfo.api_endpoint+"/api/post_comment/"));
    if (tmpFile != null) {
      request.files.add(
          await http.MultipartFile.fromPath(
              'picture', //
              tmpFile.path
          )
      );
    }
    //var res = await request.send();
    request.fields['empid'] = widget.meEmp.recid.toString();
    request.fields['comment'] = _notify_message.text;
    request.fields['receipient'] = selected_dept.ID.toString();
    var response = await request.send();

    if (response.statusCode == 200) {
      res=true;
      //print (response.body);
      //print(response.body['myJob']['jTitle']['title']);
    } else {
      // print (response.body);
    }

    return res;
  }

  Future<bool> submit_request() async {
    bool res = false;
    String sel_dates = '';

    //print (widget.myEmp.recid.toString());
    //print (selected_leave_type.value.toString());
    //print (sel_dates);
    print(tmpFile.readAsBytesSync());


    var request = http.MultipartRequest(
        'POST', Uri.parse(companyIfo.api_endpoint + "/api/post_comment/"));
    if (tmpFile != null)
      {
      request.files.add(
          http.MultipartFile.fromBytes(
            'picture',
            tmpFile.readAsBytesSync(),
            // filename: filename.split("/").last
          )
      );
     }
    request.fields['empid'] = widget.meEmp.recid.toString();
    request.fields['comment'] = _notify_message.text;
    request.fields['receipient'] = selected_dept.ID.toString();
    var response = await request.send();

    /*
    var response = await http.post(
        Uri.encodeFull("http://63.143.64.98:8090/api/post_comment/"),

        body: {
          "image": base64Image,
          'empid': widget.meEmp.recid.toString(),
          'comment': _notify_message.text,
          'receipient':selected_dept.ID.toString(),

        }

    );

     */
    print (response.reasonPhrase);
    if (response.statusCode == 200) {
      res=true;
      //print (response.body);
      //print(response.body['myJob']['jTitle']['title']);
    } else {
     // print (response.body);
    }
    return res;

  }

}