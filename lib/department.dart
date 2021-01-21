class departments {
  int ID;
  String name;


  departments({this.ID,this.name});

  factory departments.fromJson(Map<String, dynamic> json) => departments(
    ID: json["ID"],
    name: json["name"],
  );
  Map<String, dynamic> toJson() => {
    "ID": ID,
    "name": name,
  };



}