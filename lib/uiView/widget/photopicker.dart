import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class photo_picker extends StatelessWidget {
  const photo_picker({
    super.key,required this.PickedImage,
  });

  final XFile? PickedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(PickedImage == null ?"Select photo": "${PickedImage!.name}")
        ],
      ),
    );
  }
}