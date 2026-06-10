import 'package:flutter/material.dart';
import 'package:todo_project/uiView/bottom_nab_page.dart';
import 'package:todo_project/uiView/sign_in_screen.dart';
import 'package:todo_project/uiView/widget/backgroundimage.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  static final String name = "set_pass";

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background_image(child:
      Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80,),

            Text("Set new password",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  fontSize: 28
                )),

            Text("Password must be at least 8 digit \n and letter and number combination"),

            SizedBox(height: 24,),

            TextField(
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(
                  color: Colors.grey
                )
              ),
            ),

            SizedBox(height: 16,),

            TextField(
              decoration: InputDecoration(
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),

            SizedBox(height: 16,),

            SizedBox(height: 24,),

            FilledButton(
                onPressed: bottom_nab_page,
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
      ),),
    );
  }
  void signinpage(){
    Navigator.pushNamed(context, SignInScreen.name);
  }

  void bottom_nab_page(){
    Navigator.pushNamedAndRemoveUntil(context, BottomNabPage.name, (predicate)=> false);
  }
}
