class leave_entitlement {
  int leave_id;
  String leave_type;
  double accrued;
  double taken;
  double balance;

  leave_entitlement({this.leave_id,this.leave_type,this.accrued,this.taken,this.balance});

  factory leave_entitlement.fromJson(Map<String, dynamic> json) => leave_entitlement(
    leave_id: json["leave_id"],
    leave_type: json["leave_type"],
    accrued: json["accrued"],
    taken: json["taken"],
    balance: json["balance"],
  );
  Map<String, dynamic> toJson() => {
    "leave_id": leave_id,
    "leave_type": leave_type,
    "accrued": accrued,
    "taken": taken,
    "balance": balance,

  };



}