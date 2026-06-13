import 'package:flutter/material.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/controllers/newTask_model.dart';
import 'package:todo_project/uiView/widget/show_snackbar_massage.dart';
import 'package:todo_project/uiView/widget/task_card.dart';
import 'package:todo_project/utilities.dart';

class CancelTaskList extends StatefulWidget {
  const CancelTaskList({super.key});

  @override
  State<CancelTaskList> createState() => _ProgressTaskListState();
}

class _ProgressTaskListState extends State<CancelTaskList> {

  bool Inprogreess = false;
  final List<NewtaskModel> cancel_list = [];


  Future<void> _getCancelList()async{
    Inprogreess = true;
    setState(() {});

    NetworkResponse response = await Networkcoller().getrequest(Urls.CancelTaskList);

    Inprogreess = false;
    setState(() {});

    if(response.isSuccess){
      List<NewtaskModel> list = [];
      for(Map<String, dynamic> new_list in response.body["data"]){
        list.add(NewtaskModel.fromJson(new_list));
      }
      cancel_list.clear();
      cancel_list.addAll(list);
    }else{
      snakbarMassage(context, response.errormassage.toString());
    }
  }

  @override
  void initState() {
    _getCancelList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Visibility(
          visible: Inprogreess == false,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
              itemCount: cancel_list.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return TaskCard(model: cancel_list[index], refresh: () {
                  setState(() {});
                  _getCancelList();
                },);
              }),
        ),
      ),
    );
  }
}
