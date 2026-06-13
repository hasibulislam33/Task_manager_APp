import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/sign_in_screen.dart';
import 'package:todo_project/uiView/widget/backgroundimage.dart';
import 'package:todo_project/uiView/widget/show_snackbar_massage.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/utilities.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static final String name = "sign-up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _emaileditingconteroller = TextEditingController();
  final _firstnameeditingconteroller = TextEditingController();
  final _lastnameditingconteroller = TextEditingController();
  final _mobilenumberditingconteroller = TextEditingController();
  final _passwordditingconteroller = TextEditingController();

  bool signupInprogress = false;

  Future<void> _signup()async {
    signupInprogress = true;
    setState(() {});

    Map<String, dynamic> rewuestbody = {
      "email": _emaileditingconteroller.text.trim(),
      "firstName": _firstnameeditingconteroller.text.trim(),
      "lastName": _lastnameditingconteroller.text.trim(),
      "mobile": _mobilenumberditingconteroller.text.trim(),
      "password": _passwordditingconteroller.text.trim()
    };

    NetworkResponse response = await Networkcoller().postrequest(
        Urls.Registration, rewuestbody);

    signupInprogress = false;
    setState(() {});

    if (response.isSuccess) {
      clearcontroller();
      snakbarMassage(context, "Registration successful");
      Navigator.pushNamed(context, SignInScreen.name);
    } else {
      snakbarMassage(context, response.errormassage.toString());
    }
    signupInprogress = false;
    setState(() {});
  }

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background_image(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                
                    Text(
                      "Join with us",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                
                    SizedBox(height: 24),
                
                    TextFormField(
                      controller: _emaileditingconteroller,
                      decoration: InputDecoration(
                        hintText: "Email",
                        helperStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter a Email";
                        }
                        if (EmailValidator.validate(value!) == false) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                
                    TextFormField(
                      controller: _firstnameeditingconteroller,
                      decoration: InputDecoration(
                        hintText: "first name",
                        helperStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your first name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lastnameditingconteroller,
                      decoration: InputDecoration(
                        hintText: "last name",
                        helperStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your last name";
                        }
                        return null;
                      },
                    ),
                
                    TextFormField(
                      controller: _mobilenumberditingconteroller,
                      decoration: InputDecoration(
                        hintText: "mobile number",
                        helperStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your mobile number";
                        }
                        return null;
                      },
                    ),
                
                    SizedBox(height: 16),
                
                    TextFormField(
                      controller: _passwordditingconteroller,
                      decoration: InputDecoration(
                        hintText: "Pass",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "Enter a password";
                        }
                        if (value!.length < 6) {
                          return "password must at leat 6 digit";
                        }
                        return null;
                      },
                    ),
                
                    SizedBox(height: 24),
                
                    Visibility(
                      visible: signupInprogress == false,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: FilledButton(
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            _signup();
                            Navigator.pushNamed(context, SignInScreen.name);
                          }
                        },
                        child: Icon(Icons.arrow_circle_right),
                      ),
                    ),
                
                    SizedBox(height: 60),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have a account?"),
                        TextButton(onPressed: (){
                          signinpage();
                        }, child: Text("Sign in")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signinpage() {
    Navigator.pushNamed(context, SignInScreen.name);
  }
  void clearcontroller(){
    _emaileditingconteroller.clear();
    _firstnameeditingconteroller.clear();
    _lastnameditingconteroller.clear();
    _mobilenumberditingconteroller.clear();
    _passwordditingconteroller.clear();

  }

  @override
  void dispose() {
    _emaileditingconteroller.dispose();
    _firstnameeditingconteroller.dispose();
    _lastnameditingconteroller.dispose();
    _mobilenumberditingconteroller.dispose();
    _passwordditingconteroller.dispose();
    super.dispose();
  }
}






