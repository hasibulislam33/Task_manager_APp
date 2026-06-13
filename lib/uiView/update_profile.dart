import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/controllers/auth_controller.dart';
import 'package:todo_project/uiView/controllers/user_model.dart';
import 'package:todo_project/uiView/widget/TmAppBar.dart';
import 'package:todo_project/uiView/widget/backgroundimage.dart';
import 'package:todo_project/uiView/widget/show_snackbar_massage.dart';
import 'package:todo_project/utilities.dart';

class UpdateProfile extends StatefulWidget {

  static final String name = "update_profile";

  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  final _emailController = TextEditingController();
  final _firsNamecontroller = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mibileNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool InprogressUpdate = false;

  Future<void> _UpdateScreen()async{
    InprogressUpdate = true;
    setState(() {});

    Map<String, dynamic> requestbody = {
      "email": _emailController.text.trim(),
      "firstName":_firsNamecontroller.text.trim(),
      "lastName":_lastNameController.text.trim(),
      "mobile":_mibileNumberController.text.trim(),
      "password":_passwordController.text.trim()
    };

    NetworkResponse response = await Networkcoller().postrequest(Urls.profileUpdate, requestbody);

    InprogressUpdate = false;
    setState(() {});


    if(response.isSuccess){
      AuthController.user = UserModel(
        id: AuthController.user?.id?? "",
        email: _emailController.text.trim(),
        firstName: _firsNamecontroller.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobilenumber: _mibileNumberController.text.trim(),
      );
      snakbarMassage(context, "Profile Updated");
      clearController();
      setState(() {});
    }else{
      snakbarMassage(context, response.errormassage.toString());
    }
  }

  void clearController(){
    _emailController.clear();
    _firsNamecontroller.clear();
    _lastNameController.clear();
    _mibileNumberController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _firsNamecontroller.dispose();
    _lastNameController.dispose();
    _mibileNumberController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: TmAppbar(enableProfileTap: false),
      
      body: background_image(child:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),

                Text("Update your profile",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    color: Colors.red

                  ),),

                SizedBox(height: 24,),

                GestureDetector(
                  onTap: (){},
                  child: Container(
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text("Photos",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text("Select photo")
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24,),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    helperStyle: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  validator: (String? value){
                    if(value!.trim().isEmpty){
                      return "Enter a email";
                    }else{
                      null;
                    }
                    if(EmailValidator.validate(value!)== false){
                      return "Enter valid email";
                    };
                    return null;
                  },
                ),

                SizedBox(height: 16,),

                TextFormField(
                  controller: _firsNamecontroller,
                  decoration: InputDecoration(
                    hintText: "first name",
                    helperStyle: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  validator: (String? value){
                    if(value!.trim().isEmpty){
                      return "Enter a name";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16,),

                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: "last name",
                    helperStyle: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  validator: (String? value){
                    if(value!.trim().isEmpty){
                      return "Enter your last name";
                    }
                  },
                ),

                SizedBox(height: 16,),

                TextFormField(
                  controller: _mibileNumberController,
                  decoration: InputDecoration(
                    hintText: "mobile number",
                    helperStyle: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  validator: (String? value){
                    if(value!.trim().isEmpty){
                      return "Enter your mobile number";
                    }
                  },
                ),

                SizedBox(height: 16,),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: "Pass",
                      hintStyle: TextStyle(
                          color: Colors.grey
                      )
                  ),
                  validator: (String? value){
                    if(value!.trim().isEmpty){
                      return "Enter password";
                    }
                  },
                ),

                SizedBox(height: 24,),

                Visibility(
                  visible: InprogressUpdate == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: FilledButton(
                      onPressed: (){
                        if(_formkey.currentState!.validate()){
                          _UpdateScreen();
                        }
                      },
                      child: Icon(Icons.arrow_circle_right)),
                ),
              ],
            ),
          ),
        ),
      ),)
    );
  }
}
