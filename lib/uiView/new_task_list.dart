import 'package:flutter/material.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/add_new_task.dart';
import 'package:todo_project/uiView/controllers/newTask_model.dart';
import 'package:todo_project/uiView/widget/show_snackbar_massage.dart';
import 'package:todo_project/uiView/widget/task_card.dart';
import 'package:todo_project/utilities.dart';


class NewTaskList extends StatefulWidget {
  const NewTaskList({super.key});



  @override
  State<NewTaskList> createState() => _NewTaskListState();
}


class _NewTaskListState extends State<NewTaskList> {

  final List data = ["New", "Progress", "Cancel", "Complete"];

  final List<NewtaskModel> _newtasklist = [];

  bool newTaskListInprogress = false;

  Future<void> _getnewtasklist()async{
    newTaskListInprogress = true;
    setState(() {});

    final NetworkResponse response = await Networkcoller().getrequest(Urls.postreq);

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
    newTaskListInprogress = false;
    setState(() {});
  }
  @override
  void initState() {
    _getnewtasklist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 90,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
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

                          Text(_newtasklist[index].id,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge?.copyWith(
                                fontSize: 12
                              )),

                          Text(_newtasklist[index].status,
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

            Padding(
              padding: const EdgeInsets.all(10),
              child: Visibility(
                visible: newTaskListInprogress == false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (contex, index) {
                      return
                        TaskCard(model: _newtasklist[index]);
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


