import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_project/uiView/controllers/user_model.dart';

class AuthController{

  static final String _tokenkey = "token";
  static final String _user = "user";

  static String? accesskey;
  static UserModel? user;

  static Future<void> savedData(String token, UserModel model)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenkey, token);
    await preferences.setString(_user, jsonEncode(model.tojson()));
  }

  static Future<void> getdata()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    String? token = preferences.getString(_tokenkey);
    if(token != null){
      accesskey = token;
      user = UserModel.fromJson(jsonDecode(preferences.getString(_user)!));
    }
  }

  static Future<bool> idUserLogin()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    String? token = preferences.getString(_tokenkey);
    if(token != null){
      return true;
    }else{
      return false;
    }
  }

  static Future<void> removeLoginData()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

}