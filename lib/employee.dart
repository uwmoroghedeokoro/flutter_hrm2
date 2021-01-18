import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_hrm/sub_sups.dart';

class employee
{
  int recid;
  String empno;
  String fname;
  String lname;
  String jobTitle;
  String department;
  String hireDate;
  String nis;
  String trn;
  String marry_status;
  String email;
  String dob;
  String address;
  String city;
  String country;
  String mobile;
  String hometel;

  String eLocation;
  String eCountry;
  String emp_status;
  String job_category;

  String pay_grade;
  String pay_freq;
  String pay_currency;
  double pay_amount;
  String pay_effective;
  double pay_veh_allowance;


  List<sub_sups>sups=[];

  employee({this.pay_grade,this.pay_freq,this.pay_currency,this.pay_amount,this.pay_effective,this.pay_veh_allowance,this.sups,this.emp_status,this.job_category,this.mobile,this.hometel,this.eLocation,this.eCountry,this.address,this.city,this.country,this.dob,this.empno,this.fname,this.lname,this.recid,this.jobTitle,this.department,this.hireDate,this.nis,this.trn,this.marry_status,this.email});

  factory employee.fromJson(Map<String, dynamic> json) {

    var tagObjsJson = json['mySupervisors'] as List;
    List<sub_sups> _tags = tagObjsJson.map((tagJson) => sub_sups.fromJson(tagJson)).toList();

    return employee(

      pay_grade: json['salary']['pay_grade']['name'],
      pay_freq: json['salary']['freq'],
      pay_currency: json['salary']['currency'],
      pay_amount: json['salary']['amount'],
      pay_effective: json['salary']['recDate'],
      pay_veh_allowance: json['salary']['vehAllow'],
      empno: json['empid'],
      recid: json['recid'],
      fname: json['fname'],
      lname: json['lname'],
      jobTitle: json['myJob']['jTitle']['title'],
      department: json['myJob']['edepartment']['name'],
      address:json['address'],
      city:json['city'],
      country: json['country'],
      email: json['emailwork'],
      eLocation: json['myJob']['elocation']['name'],
      eCountry: json['myJob']['elocation']['country'],
      dob:json['dob'],
      mobile: json['mobile'],
      hometel: json['hometel'],
      trn: json['trn'],
      nis: json['nis'],
      hireDate: json['myJob']['joindate'],
      emp_status: json['myJob']['empStatus']['status'],
      job_category: json['myJob']['eCategory']['category'],
      sups: _tags
    );
  }






 // String fullname(){return fname + ' ' + lname;}

}