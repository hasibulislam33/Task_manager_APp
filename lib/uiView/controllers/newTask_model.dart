class NewtaskModel {
  final String id;
  final String title;
  final String description;
  final String email;
  final String status;
  final String createDate;

  NewtaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.email,
    required this.status,
    required this.createDate,
  });

  factory NewtaskModel.fromJson(Map<String, dynamic>jsondata){
    return NewtaskModel(
        id: jsondata["id"],
        title: jsondata["email"],
        description: jsondata["description"],
        email: jsondata["email"],
        status: jsondata["status"],
        createDate: jsondata["createDate"]);
  }
}
