import 'package:flutter/material.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/add_new_task.dart';
import 'package:todo_project/uiView/controllers/newTask_model.dart';
import 'package:todo_project/uiView/controllers/task_status_mdel.dart';
import 'package:todo_project/uiView/widget/show_snackbar_massage.dart';
import 'package:todo_project/uiView/widget/task_card.dart';
import 'package:todo_project/utilities.dart';


class NewTaskList extends StatefulWidget {
  const NewTaskList({super.key});

  static final String name = "new_task_list";



  @override
  State<NewTaskList> createState() => _NewTaskListState();
}


class _NewTaskListState extends State<NewTaskList> {

  final List data = ["New", "Progress", "Cancel", "Complete"];

  final List<NewtaskModel> _newtasklist = [];

  final List<TaskStatusMdel> _newstatus = [];

  bool newTaskListInprogress = false;

  bool newtaskstatusInprogress = false;

  Future<void> _getnewtasklist()async{
    newTaskListInprogress = true;
    setState(() {});

    final NetworkResponse response = await Networkcoller().getrequest(Urls.newtaskList);

    newTaskListInprogress = false;
    setState(() {});

    if(response.isSuccess){
      List<NewtaskModel> list = [];
      for(Map<String, dynamic>jsonData in response.body["data"]) {
        list.add(NewtaskModel.fromJson(jsonData));
      }
      _newtasklist.clear();
       _newtasklist.addAll(list);
    }else{
      snakbarMassage(context, response.errormassage.toString());
    }
  }

  Future<void> _getNewTaskStatus()async{
    newtaskstatusInprogress = true;
    setState(() {});

    final NetworkResponse response = await Networkcoller().getrequest(Urls.taskStattus);

    newtaskstatusInprogress = false;
    setState(() {});

    if(response.isSuccess){
      List<TaskStatusMdel> list = [];
      for(Map<String, dynamic>jsonData in response.body["data"]) {
        list.add(TaskStatusMdel.fromJson(jsonData));
      }
      _newstatus.clear();
      _newstatus.addAll(list);

    }else{
      snakbarMassage(context, response.errormassage.toString());
    }
  }


  @override
  void initState() {
    super.initState();
    _getnewtasklist();
    _getNewTaskStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 90,
              child: Visibility(
                visible:newtaskstatusInprogress == false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _newstatus.length,
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10.0, bottom: 10.0),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        width: 70,
                        height: 20,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Text(_newstatus[index].id.toString(),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge?.copyWith(
                                  fontSize: 12
                                )),

                            Text(_newstatus[index].sum.toString(),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge?.copyWith(
                                fontSize: 12
                              )),
                          ],
                        ),
                      );
                    }),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Visibility(
                visible: newTaskListInprogress == false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _newtasklist.length,
                    shrinkWrap: true,
                    itemBuilder: (contex, index) {
                      return
                        TaskCard(model: _newtasklist[index], refresh: () {
                          _getnewtasklist();
                          _getNewTaskStatus();
                        },);
                    }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: add_new_task,
        child: Icon(Icons.add),),
    );
  }
  void add_new_task(){
    Navigator.pushNamed(context, AddNewTask.name);
  }
}


