import 'package:flutter/material.dart';
import 'package:todo_project/uiView/bottom_nab_page.dart';
import 'package:todo_project/uiView/controllers/auth_controller.dart';
import 'package:todo_project/uiView/images_utilities.dart';
import 'package:todo_project/uiView/sign_in_screen.dart';
import 'package:todo_project/uiView/widget/backgroundimage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static final String name = "/splash";

  @override
  State<SplashScreen> createState() => _HomeState();
}

class _HomeState extends State<SplashScreen> {
  Future splash() async {
    await Future.delayed(Duration(seconds: 2));
    if (await AuthController.idUserLogin() == true) {
      await AuthController.getdata();
      Navigator.pushReplacementNamed(context, BottomNabPage.name);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SignInScreen()),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background_image(
        child: Center(child: Image.asset(image_path.splash_logo, width: 150)),
      ),
    );
  }
}
