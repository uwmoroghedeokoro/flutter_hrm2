class sub_sups {
  int sub_sup_id;
  String sub_sup_name;

  sub_sups({this.sub_sup_id,this.sub_sup_name});
  factory sub_sups.fromJson(Map<String, dynamic> json) {
    return sub_sups(
      sub_sup_id: json['supID'],
      sub_sup_name: json['supName'],

    );
  }
}