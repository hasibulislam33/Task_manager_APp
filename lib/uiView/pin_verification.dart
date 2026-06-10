import 'package:flutter/material.dart';
import 'package:todo_project/uiView/set_password.dart';
import 'package:todo_project/uiView/sign_in_screen.dart';
import 'package:todo_project/uiView/widget/backgroundimage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  static final String name = "pin_verification";

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
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

              Text("PIN verification",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold
                  )),

              Text("Check your email address a 6 digit pin send"),

              SizedBox(height: 24,),

              PinInput(
                length: 6,
                obscureText: true,
                builder: (context, cells) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: cells.map((cell) {
                      return Container(
                        width: 30,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: cell.isFocused ? Colors.white : Colors.grey[200],
                        ),
                        child: Center(
                          child: Text(
                            cell.character ?? '',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                onCompleted: (pin) => print('PIN: $pin'),
              ),

              SizedBox(height: 16,),

              SizedBox(height: 24,),

              FilledButton(
                  onPressed: nextpage,
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

  void nextpage(){
    Navigator.pushNamed(context, SetPassword.name);
  }
}
