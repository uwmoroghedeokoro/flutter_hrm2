class message_note {
  int postID;
  String postedBy;
  String postedOn;
  String postedMessage;
  String postedDoc;

  message_note({this.postID,this.postedBy,this.postedOn,this.postedMessage,this.postedDoc});

  factory message_note.fromJson(Map<String, dynamic> json) => message_note(
    postID: json["trailid"],
    postedBy: json["postBy"],
    postedMessage: json["trailMessage"],
    postedDoc: json["post_doc"],
    postedOn: json["posted"],
  );
  /*
  Map<String, dynamic> toJson() => {
    "leave_id": leave_id,
    "leave_type": leave_type,
    "accrued": accrued,
    "taken": taken,
    "balance": balance,

  };
*/


}