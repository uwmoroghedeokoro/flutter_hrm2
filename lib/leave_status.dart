class leave_status {
  int leave_id;
  int req_id;
  String leave_type;
  String status;
  int req_days;
  String start_date;
  String return_date;
  String emp_name;
  int emp_id;


  leave_status({this.emp_id,this.req_id,this.emp_name,this.leave_id,this.leave_type,this.status,this.req_days,this.start_date,this.return_date});

  factory leave_status.fromJson(Map<String, dynamic> json) => leave_status(
    leave_id: json["leave_id"],
    leave_type: json["leave_type"],
    status: json["status"],
    req_days: json["req_days"],
    start_date: json["start_date"],
    return_date: json["return_date"],
    emp_name: json["emp_name"],
      req_id: json["req_id"],
    emp_id: json["emp_id"]

  );
  Map<String, dynamic> toJson() => {
    "leave_id": leave_id,
    "req_id": req_id,
    "leave_type": leave_type,
    "status": status,
    "req_days": req_days,
    "start_date": start_date,
    "return_date": return_date,
    "emp_name":emp_name,
    "emp_id" : emp_id
  };



}