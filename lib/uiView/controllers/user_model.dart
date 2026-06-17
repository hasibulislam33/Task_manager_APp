class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobilenumber;
  String photo;

  String get fullname {
    return "$firstName $lastName";
  }

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobilenumber,
    required this.photo
  });

  factory UserModel.fromJson(Map<String, dynamic> jsondata) {
    return UserModel(
      id: jsondata["_id"] ?? "",
      email: jsondata["email"] ?? "",
      firstName: jsondata["firstName"] ?? "",
      lastName: jsondata["lastName"] ?? "",
      mobilenumber: jsondata["mobile"] ?? "",
      photo: jsondata["photo"] ?? ""
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "_id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobilenumber,
      "photo": photo
    };
  }
}
