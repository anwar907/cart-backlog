class TodoModels {
  int userId;
  int id;
  String title;
  int qty;

  TodoModels({this.userId, this.id, this.title, this.qty});

  factory TodoModels.fromJson(Map<String, dynamic> json) => TodoModels(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        qty: json['qty'],
      );

  Map<String, dynamic> toJson() => {
        'userId': this.userId,
        'id': this.id,
        'title': this.title,
        'qty': this.qty
      };
}