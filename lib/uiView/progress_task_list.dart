import 'package:flutter/material.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/controllers/newTask_model.dart';
import 'package:todo_project/uiView/widget/task_card.dart';
import 'package:todo_project/utilities.dart';

class ProgressTaskList extends StatefulWidget {
  const ProgressTaskList({super.key});

  @override
  State<ProgressTaskList> createState() => _ProgressTaskListState();
}

class _ProgressTaskListState extends State<ProgressTaskList> {

  bool InProgress = false;
  List<NewtaskModel> progress_list = [];


  Future<void> _progressList()async{
    InProgress = true;
    setState(() {});
    NetworkResponse response = await Networkcoller().getrequest(Urls.progressTasklist);

    InProgress = false;
    setState(() {});
    List<NewtaskModel> list = [];
    if(response.isSuccess){
      for(Map<String, dynamic> jsondata in response.body["data"]){
        list.add(NewtaskModel.fromJson(jsondata));
      }
      progress_list.clear();
      progress_list.addAll(list);
    }
  }

  @override
  void initState() {
      _progressList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Visibility(
          visible: InProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: progress_list.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return TaskCard(model:progress_list[index], refresh: () {
                  _progressList();
                },);
              }),
        ),
      ),
    );
  }
}
