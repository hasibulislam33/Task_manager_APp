class UserModel {
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final String mobilenumber;

  UserModel({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.mobilenumber,
  });

  factory UserModel.fromJson(Map<String, dynamic>jsondata){
    return UserModel(
        id: jsondata["id"],
        email: jsondata["email"],
        firstname: jsondata["firstname"],
        lastname: jsondata["lastname"],
        mobilenumber: jsondata["mobilenumber"]);
  }

  Map<String, dynamic>tojson(){
    return {
      "id": id,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "mobilenumber": mobilenumber
    };
  }
}
