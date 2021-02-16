import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_hrm/sub_sups.dart';
import 'department.dart';
import 'department.dart';
class employee
{
  int recid;
  String empno;
  String fname;
  String lname;
  String jobTitle;
  String department;
  int deptid;
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
  bool hr_team;


  List<departments> depts=[];
  List<sub_sups>sups=[];

  employee({this.deptid,this.depts, this.hr_team,this.pay_grade,this.pay_freq,this.pay_currency,this.pay_amount,this.pay_effective,this.pay_veh_allowance,this.sups,this.emp_status,this.job_category,this.mobile,this.hometel,this.eLocation,this.eCountry,this.address,this.city,this.country,this.dob,this.empno,this.fname,this.lname,this.recid,this.jobTitle,this.department,this.hireDate,this.nis,this.trn,this.marry_status,this.email});

  factory employee.fromJson(Map<String, dynamic> json) {

    var tagObjsJson = json['mySupervisors'] as List;
    List<sub_sups> _tags = tagObjsJson.map((tagJson) => sub_sups.fromJson(tagJson)).toList();

    var tagObjsJson2 = json['my_departments'] as List;
    List<departments> _depts = tagObjsJson2.map((tagJson) => departments.fromJson(tagJson)).toList();

    return employee(
      hr_team: json['hr_team'],
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
        deptid: json['myJob']['edepartment']['ID'],
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
      sups: _tags,
      depts: _depts
    );
  }

  Map<String,dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["hr_team"] = hr_team;
    map['salary']['pay_grade']['name']=pay_grade;
    map['salary']['freq']=pay_freq;
   map['salary']['currency']=pay_currency;
    map['salary']['amount']=pay_amount;
    map['salary']['recDate']=pay_effective;
    map['salary']['vehAllow']=pay_veh_allowance;
    map['empid']=empno;
    map['recid']=recid;
    map['fname']=fname;
    map['lname']=lname;
    map['myJob']['jTitle']['title']=jobTitle;
    map['myJob']['edepartment']['name']=department;
    map['myJob']['edepartment']['ID']=deptid;
    map['address']=address;
    map['city']=city;
    map['country']=country;
    map['emailwork']=email;
    map['myJob']['elocation']['name']=eLocation;
    eCountry: map['myJob']['elocation']['country']=eCountry;
    map['dob']=dob;
    map['mobile']=mobile;
    map['hometel']=hometel;
    map['trn']=trn;
    map['nis']=nis;
    map['myJob']['joindate']=hireDate;
    map['myJob']['empStatus']['status']=emp_status;
    map['myJob']['eCategory']['category']=job_category;
    //sups: _tags,
   // depts: _depts
    // Add all other fields
    return map;
  }




 // String fullname(){return fname + ' ' + lname;}

}