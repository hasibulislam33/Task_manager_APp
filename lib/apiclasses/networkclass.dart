import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_project/main.dart';
import 'package:todo_project/uiView/controllers/auth_controller.dart';
import 'package:todo_project/uiView/sign_in_screen.dart';

class Networkcoller {
  Future<NetworkResponse> getrequest(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"token": AuthController.accesskey ?? ""},
      );

      final decoded = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statuscode: response.statusCode,
          body: decoded,
        );
      } else if (response.statusCode == 401) {
        _Unauthorized();
        return NetworkResponse(
          isSuccess: false,
          statuscode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statuscode: response.statusCode,
          errormassage: "Unauthorized",
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statuscode: -1,
        errormassage: e.toString(),
      );
    }
  }

  static Future<void> _Unauthorized() async {
    await AuthController.removeLoginData();
    MyApp.navigator.currentState?.pushNamed(SignInScreen.name);
  }

  Future<NetworkResponse> postrequest(
    String url,
    Map<String, dynamic>? body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "token": AuthController.accesskey ?? "",
        },
        body: jsonEncode(body),
      );

      final decoded = jsonDecode(response.body);
      if (response.statusCode ==200) {
        return NetworkResponse(
          isSuccess: true,
          statuscode: response.statusCode,
          body: decoded,
        );
      } else if (response.statusCode == 401) {
        _Unauthorized();
        return NetworkResponse(
          isSuccess: false,
          statuscode: response.statusCode,
          errormassage: "Un-Authorized",
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statuscode: response.statusCode,
          errormassage: response.body,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statuscode: -1,
        errormassage: e.toString(),
      );
    }
  }
}

class NetworkResponse {
  bool isSuccess;
  dynamic? statuscode;
  dynamic? body;
  String? errormassage;

  NetworkResponse({
    required this.isSuccess,
    required this.statuscode,
    this.body,
    this.errormassage,
  });
}
