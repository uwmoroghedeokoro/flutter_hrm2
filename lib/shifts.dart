
class shifts {
  String name;
  String start;
  String end;
  String color;
  String date;
  String emp_name;

  shifts({this.emp_name,this.date,this.name,this.start,this.end,this.color});

  factory shifts.fromJson(Map<String, dynamic> json)
  {
    return shifts(
      name:json['shiftname'],
      start: json['shiftstart'],
      end: json['shiftend'],
      color: json['shiftcolor'],
      date:json['shiftdate'],
      emp_name: json['emp_name']
    );
  }
}