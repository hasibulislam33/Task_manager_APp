import 'package:flutter/material.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/controllers/newTask_model.dart';
import 'package:todo_project/uiView/widget/task_card.dart';
import 'package:todo_project/utilities.dart';

class CompleteTaskList extends StatefulWidget {
  const CompleteTaskList({super.key});

  @override
  State<CompleteTaskList> createState() => _ProgressTaskListState();
}

class _ProgressTaskListState extends State<CompleteTaskList> {
  
  List<NewtaskModel> complete_list = [];
  bool Complete_inProgress = false;
  
  Future<void> Complete_task()async{
    
    setState(() {
      Complete_inProgress = true;
    });
    
    NetworkResponse response = await Networkcoller().getrequest(Urls.postreq);
    if(response.isSuccess){
      List<NewtaskModel> list = [];
      for(Map<String, dynamic> jsonData in response.body["data"]){
        list.add(NewtaskModel.fromJson(jsonData));
      }
      complete_list = list;
    }
    setState(() {
      Complete_inProgress = false;
    });
  }

  @override
  void initState() {
    Complete_task();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Visibility(
          visible: Complete_inProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
              itemCount: complete_list.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return TaskCard(model: complete_list[index]);
              }),
        ),
      ),
    );
  }
}
