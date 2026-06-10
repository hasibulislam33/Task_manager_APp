import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/Splash_Screen.dart';
import 'package:todo_project/uiView/bottom_nab_page.dart';
import 'package:todo_project/uiView/controllers/auth_controller.dart';
import 'package:todo_project/uiView/controllers/user_model.dart';
import 'package:todo_project/uiView/forget_by_email.dart';
import 'package:todo_project/uiView/sign_up_screen.dart';
import 'package:todo_project/uiView/widget/backgroundimage.dart';
import 'package:todo_project/uiView/widget/show_snackbar_massage.dart';
import 'package:todo_project/utilities.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static final String name = "sign-in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _signInprogress = false;

 Future<void> _signin()async{
   _signInprogress = true;
   setState(() {});



   Map<String, dynamic> requestbody = {
     "email" : _emailcontroller.text.trim(),
     "password": _passwordcontroller.text.trim()
   };

   NetworkResponse response = await Networkcoller().postrequest(Urls.Login, requestbody);
   print("isSuccess: ${response.isSuccess}");
   print("statusCode: ${response.statuscode}");
   print("body: ${response.body}");
   print("error: ${response.errormassage}");

   if(response.isSuccess){
     UserModel userModel = UserModel.fromJson(response.body["data"]);
     String accesskey = response.body["token"];
     AuthController.savedData(accesskey, userModel);
     _signInprogress = false;
     setState(() {});
     Navigator.pushReplacementNamed(context, BottomNabPage.name);
   }else{
     snakbarMassage(context, response.errormassage.toString());
     _signInprogress = false;
     setState(() {});
   }
 }
 @override
  void dispose() {
   _emailcontroller.dispose();
   _passwordcontroller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        background_image(child:
        Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80,),
              
                  Text("Get start with",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),),
              
                  SizedBox(height: 24,),
              
                  TextFormField(
                    controller: _emailcontroller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "Email",
                      helperStyle: TextStyle(
                        color: Colors.grey[400]
                      ),
                    ),
                    validator: (String ? value){
                      if(value?.trim().isEmpty ?? true){
                        return "Enter a E-mail";
                      }
                      if(EmailValidator.validate(value!)== false){
                        return "enter valid mail";
                      }
                      return null;
                    },
                  ),
              
                  SizedBox(height: 16,),
              
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordcontroller,
                    decoration: InputDecoration(
                      hintText: "Pass",
                      hintStyle: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                    validator: (String? value){
                      if(value?.isEmpty ?? true){
                        return "enter password";
                      }return null;
                    },
                  ),
              
                  SizedBox(height: 24,),
                  
                  Visibility(
                    visible: _signInprogress == false,
                    replacement: Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: FilledButton(
                        onPressed: (){
                          if(_formkey.currentState!.validate()){
                            _signin();
                          };
                        },
                        child: Icon(Icons.arrow_circle_right)),
                  ),
              
                  SizedBox(height: 60,),
                  
                  Center(
                      child: TextButton(onPressed: forgetpass, child: Text("Forget Password?",
                      ))),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have a account?"),
                      TextButton(onPressed: signuppage, child: Text("Sign up"))
                    ],
                  )
              
                ],
              ),
            ),
          ),
        ),),
    );
  }

  void signuppage(){
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  void forgetpass(){
    Navigator.pushNamedAndRemoveUntil(context, ForgetByEmail.name, (predicat)=> false);
  }

  void bottom_nab_page(){
    Navigator.pushNamed(context, BottomNabPage.name);
  }
}
