import 'package:flutter/material.dart';
import 'package:todo_project/uiView/images_utilities.dart';
class background_image extends StatelessWidget {

  final Widget child;

  const background_image({
    super.key, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(image_path.splash_bk,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,),
        child
      ],
    );
  }
}