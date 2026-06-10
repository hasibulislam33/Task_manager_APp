import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/uiView/controllers/auth_controller.dart';
import 'package:todo_project/uiView/sign_in_screen.dart';
import 'package:todo_project/uiView/update_profile.dart';
import 'package:todo_project/utilities/image_link.dart';

class TmAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool enableProfileTap;
  const TmAppbar({
    super.key,
    required this.enableProfileTap,
  });


  @override
  Widget build(BuildContext context) {

    late final textTheme =  Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        spacing: 12,
        children: [
          GestureDetector(
            onTap: (){
              enableProfileTap ? Navigator.pushNamed(context, UpdateProfile.name) :
                  null;
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("",),
            ),
          ),
          Text("Hasibul Islam Shanto\nhasibul9321@gmail.com",
              style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w200
              )),
        ],
      ),
      actions: [
        IconButton(onPressed: (){
          showDialog(context: context, builder: (contex){
            return AlertDialog(
              title: Text("Are you sure?",
              style: TextStyle(
                color: Colors.red
              ),),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: ()async{
                      await AuthController.removeLoginData();
                      Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
                    }, child: Text("Log out",
                    style: TextStyle(
                      color: Colors.red
                    ),)),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel"))
                  ],
                )

              ],
            );
          });
        }, icon: Icon(Icons.logout,color: Colors.white,))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}