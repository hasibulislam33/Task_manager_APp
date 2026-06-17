import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/controllers/auth_controller.dart';
import 'package:todo_project/uiView/controllers/user_model.dart';
import 'package:todo_project/uiView/widget/TmAppBar.dart';
import 'package:todo_project/uiView/widget/backgroundimage.dart';
import 'package:todo_project/uiView/widget/photopicker.dart';
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

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool InprogressUpdate = false;
  XFile? _pickedImage;

  Future<void> _UpdateScreen()async {
    InprogressUpdate = true;
    setState(() {});

    Map<String, dynamic> requestbody = {
      "email": _emailController.text.trim(),
      "firstName": _firsNamecontroller.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mibileNumberController.text.trim(),
    };
    if (_passwordController.text.isNotEmpty) {
      requestbody["password"] = _passwordController.text;
    }
    if (_pickedImage != null) {
      List<int>imageByte = await _pickedImage!.readAsBytes();
      requestbody['photo']=base64Encode(imageByte);
    }


    NetworkResponse response = await Networkcoller().postrequest(
        Urls.profileUpdate, requestbody);




    if (response.isSuccess) {

      await AuthController.userUpdate(UserModel.fromJson(requestbody));

      if(!mounted)return;
      snakbarMassage(context, "Profile Updated");

      /*AuthController.user = UserModel(
        id: AuthController.user?.id ?? "",
        email: _emailController.text.trim(),
        firstName: _firsNamecontroller.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobilenumber: _mibileNumberController.text.trim(),
        photo: _pickedImage != null
            ? base64Encode(await _pickedImage!.readAsBytes())
            : AuthController.user!.photo,
      );*/
      /*await AuthController.savedData(
          AuthController.accesskey!, AuthController.user!);
      snakbarMassage(context, "Profile Updated");
    }else{
      snakbarMassage(context, response.errormassage.toString());
    }*/
    }
    if(!response.isSuccess){
      print(response.errormassage);
      snakbarMassage(context, response.errormassage!);
      //snakbarMassage(context, 'NotSuccess');
    }
    InprogressUpdate = false;
    setState(() {});
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
  void initState() {
    super.initState();
    final UserModel usermodel = AuthController.user!;
    _emailController.text  = usermodel.email;
    _firsNamecontroller.text = usermodel.firstName;
    _lastNameController.text = usermodel.lastName;
    _mibileNumberController.text = usermodel.mobilenumber;
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
                SizedBox(height: 40,),

                GestureDetector(
                  onTap: pickupImage,
                  child:
                  photo_picker(PickedImage: _pickedImage,),
                ),

                SizedBox(height: 24,),

                TextFormField(
                  enabled: false,
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
                    if(EmailValidator.validate(value)== false){
                      return "Enter valid email";
                    }
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
                    return null;
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
                    return null;
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
                   String password = value ?? "";
                   if(password.isNotEmpty && password.length <6){
                     return "Password must be 6 digit";
                   }
                   return null;
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
  Future<void> pickupImage()async{
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 98);
    if(image != null){
      _pickedImage = image;
      setState(() {});
    }
  }
}



