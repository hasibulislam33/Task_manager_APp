import 'package:flutter/material.dart';
import 'package:todo_project/uiView/pin_verification.dart';
import 'package:todo_project/uiView/sign_in_screen.dart';
import 'package:todo_project/uiView/widget/backgroundimage.dart';

class ForgetByEmail extends StatefulWidget {
  const ForgetByEmail({super.key});

  static final String name = "forget_email";

  @override
  State<ForgetByEmail> createState() => _ForgetByEmailState();
}

class _ForgetByEmailState extends State<ForgetByEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background_image(
        child:
        Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),

              Text("Your email address",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28
              )),

              Text("A 6 verification otp will be send to your email"),

              SizedBox(height: 24,),

              TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  helperStyle: TextStyle(
                      color: Colors.grey[400]
                  ),
                ),
              ),

              SizedBox(height: 16,),

              SizedBox(height: 24,),

              FilledButton(
                  onPressed: pinverification_page,
                  child: Icon(Icons.arrow_circle_right)),

              SizedBox(height: 60,),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?"),
                  TextButton(onPressed: signinpage, child: Text("Sign in"))
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  void signinpage(){
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicat)=> false);
  }

  void pinverification_page(){
    Navigator.pushNamedAndRemoveUntil(context, PinVerification.name, (predicat)=> false);
  }
}
