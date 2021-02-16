import 'package:flutter/material.dart';
import 'package:flutter_hrm/initialize_page.dart';
import 'package:flutter_hrm/login.dart';
import 'package:flutter_hrm/main_dash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 // SharedPreferences.setMockInitialValues({});

  try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String api_domain = pref.getString('api_domain') ?? "-";
    int empid=pref.getInt("empid") ?? -1;


    if (api_domain != "-" && empid ==-1) {
      print ('stored empid ' + empid.toString());
      runApp(
       Login() // main_dash()
      );
    }else if (api_domain != "-" && empid > 0)
    {
      runApp(main_dash());
    }
    else {
      runApp(initialize_page());
    }
  }catch (ex)
  {
    print ('Exception error ' + ex);
    runApp(initialize_page());
  }
}

