class Response {
  int? userId;
  int? id;
  String? title;
  bool? completed;
  Response(this.userId, this.id,this.title,this.completed);

  Response.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title=json['title'],
        completed=json['completed'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title':title,
        'completed':completed
      };
}
