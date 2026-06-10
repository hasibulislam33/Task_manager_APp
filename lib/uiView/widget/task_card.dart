import 'package:flutter/material.dart';
import 'package:todo_project/uiView/controllers/newTask_model.dart';

Card TaskCard({required NewtaskModel model}) {
  return Card(
    child: ListTile(
      title: Text(model.title, style: TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model.description, style: TextStyle(color: Colors.grey)),
          Text(model.createDate),

          Row(
            children: [
              Container(
                width: 60,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    model.status,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              Spacer(),

              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, color: Colors.grey),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
