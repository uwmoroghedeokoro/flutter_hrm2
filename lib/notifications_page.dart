import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hrm/employee.dart';
import 'package:flutter_hrm/leave_status.dart';
import 'package:flutter_hrm/new_notification.dart';
import 'package:flutter_hrm/pageTransition.dart';
import 'package:flutter_hrm/request_leave.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'company_info.dart';
import 'message_note.dart';
import 'HexColor.dart';
import 'leave_entitlement.dart';
//import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
//import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
        ),
      floatingActionButton:
      FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
            Icons.add
        ),
        onPressed: (){
          Navigator.of(context).push(pageTransition().createRoute(new_notification(meEmp: widget.emp)));
        },
      ),

    );
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

  @override
  void initState(){

    companyIfo.company_name='-';

    setState(() {
      //companyIfo.company_name='NOT BLANK';
      getStringValuesSF();
    });
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
                        margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        width: 40, height: 40,
                        decoration: BoxDecoration(
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
                          Text(this_trail.postedOn,style:TextStyle(color:Colors.grey,fontSize:12,fontWeight:FontWeight.normal)),
                        ],
                      ),


                    ],
                  ),


                ],
              ),
              SizedBox(height: 10,),
              Text(this_trail.postedMessage,style:TextStyle(color:Colors.black87,fontSize: 15)),
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
        );
      },
    );
  }


  Future<List<message_note>> _getTrails() async {
    var response = await http.get(
        Uri.encodeFull(companyIfo.api_endpoint+ "/api/get_trail/"+ widget.emp.recid.toString()),
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

class view_pdf extends StatelessWidget{
  String pdf_path='';

  view_pdf({this.pdf_path});
  PageController pdf_controller=PageController();
  Future<PDFDocument> getPDF(String pdf_url) async
  {
    PDFDocument mPDF=PDFDocument();
    mPDF = await PDFDocument.fromURL(
      "http://hrm.islandroutes.com:8070/sharePhotos/"+pdf_url,
      /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
    );
    final int pg=1;
    PDFPage pageOne = await mPDF.get(page: 1);
    pdf_controller=PageController(initialPage: 0,keepPage: true);
    return mPDF;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Attachment'),),
      body: Container(
        padding: EdgeInsets.all(2),
        child: FutureBuilder(
            future: getPDF(pdf_path),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              PDFDocument mPDF=snapshot.data;
              // PDFPage pageOne = await mPDF.get(page: 1);
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return
                      Container(
                        //  height: 300,
                          width: double.infinity,
                          child:
                          PDFViewer(controller: pdf_controller, minScale: 60, showNavigation: true, showPicker: false, document: snapshot.data, lazyLoad: true, zoomSteps: 5,));

              }
            }
        ),
      ),
    );
  }
}