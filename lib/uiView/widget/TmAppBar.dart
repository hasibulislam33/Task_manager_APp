import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:todo_project/uiView/controllers/auth_controller.dart';
import 'package:todo_project/uiView/sign_in_screen.dart';
import 'package:todo_project/uiView/update_profile.dart';
import 'dart:typed_data';

class TmAppbar extends StatefulWidget implements PreferredSizeWidget {
  final bool enableProfileTap;
  const TmAppbar({
    super.key,
    required this.enableProfileTap,
  });



  @override
  State<TmAppbar> createState() => _TmAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


}

class _TmAppbarState extends State<TmAppbar> {

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;

    if (AuthController.user?.photo != null &&
        AuthController.user!.photo!.isNotEmpty) {
      imageBytes = base64Decode(AuthController.user!.photo!);
    }
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        spacing: 12,
        children: [
          GestureDetector(
            onTap: () async {
              if (widget.enableProfileTap) {
                await Navigator.pushNamed(context, UpdateProfile.name);
                setState(() {});
              }
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage:
              imageBytes != null
                  ? MemoryImage(imageBytes!)
                  : null,
              child:
              imageBytes == null
                  ? const Icon(Icons.person)
                  : null,
            )
          ),
          Text(
            "${AuthController.user?.fullname}\n${AuthController.user?.email}",
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text("Are you sure?",
                      style: TextStyle(color: Colors.red)),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await AuthController.removeLoginData();
                            Navigator.pushNamedAndRemoveUntil(
                                context, SignInScreen.name, (p) => false);
                          },
                          child: Text("Log out",
                              style: TextStyle(color: Colors.red)),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.logout, color: Colors.white),
        ),
      ],
    );
  }
}