import 'package:flutter/material.dart';
import 'package:todo_project/uiView/widget/TmAppBar.dart';
import 'package:todo_project/uiView/widget/backgroundimage.dart';

class UpdateProfile extends StatefulWidget {

  static final String name = "update_profile";

  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: TmAppbar(enableProfileTap: false),
      
      body: background_image(child:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
        
              Text("Update your profile",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,

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
        
              TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  helperStyle: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ),
        
              SizedBox(height: 16,),
        
              TextField(
                decoration: InputDecoration(
                  hintText: "first name",
                  helperStyle: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ),
        
              SizedBox(height: 16,),
        
              TextField(
                decoration: InputDecoration(
                  hintText: "last name",
                  helperStyle: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ),
        
              SizedBox(height: 16,),
        
              TextField(
                decoration: InputDecoration(
                  hintText: "mobile number",
                  helperStyle: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ),
        
              SizedBox(height: 16,),
        
              TextField(
                decoration: InputDecoration(
                    hintText: "Pass",
                    hintStyle: TextStyle(
                        color: Colors.grey
                    )
                ),
              ),
        
              SizedBox(height: 24,),
        
              FilledButton(
                  onPressed: (){},
                  child: Icon(Icons.arrow_circle_right)),
            ],
          ),
        ),
      ),)
    );
  }
}
