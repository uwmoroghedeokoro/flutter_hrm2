import 'package:flutter/material.dart';
import 'package:flutter_hrm/initialize_page.dart';
import 'package:flutter_hrm/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref=await SharedPreferences.getInstance();
  String api_domain=pref.getString('api_domain');
  if (api_domain !=null || api_domain !="") {
    runApp(
        Login()
    );
  }else
    {
      runApp(initialize_page());
    }

}

