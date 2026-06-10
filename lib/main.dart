import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/uiView/Splash_Screen.dart';
import 'package:todo_project/uiView/add_new_task.dart';
import 'package:todo_project/uiView/bottom_nab_page.dart';
import 'package:todo_project/uiView/forget_by_email.dart';
import 'package:todo_project/uiView/pin_verification.dart';
import 'package:todo_project/uiView/sign_in_screen.dart';
import 'package:todo_project/uiView/sign_up_screen.dart';
import 'package:todo_project/uiView/set_password.dart';
import 'package:todo_project/uiView/update_profile.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  static GlobalKey<NavigatorState>  navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
        ),
        scaffoldBackgroundColor: Colors.green[100],

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade700),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              padding: EdgeInsets.all(15),
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              fixedSize: Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)
              )
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
            helperStyle: TextStyle(
                color: Colors.grey
            ),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),

            errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),

            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            )
        )
      ),
      title: "To Do App",

      routes: {
        "/splash" : (_)=> SplashScreen(),
        "sign-in": (_)=> SignInScreen(),
        "sign-up": (_)=> SignUpScreen(),
        "forget_email": (_)=> ForgetByEmail(),
        "pin_verification": (_)=> PinVerification(),
        "set_pass": (_)=> SetPassword(),
        "bottom_home_page": (_)=> BottomNabPage(),
        "add_new_task" : (_)=> AddNewTask(),
        "update_profile": (_)=> UpdateProfile()
      },

      home: SplashScreen(),
    );
  }
}
