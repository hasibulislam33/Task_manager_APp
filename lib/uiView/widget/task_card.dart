import 'package:flutter/material.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/controllers/newTask_model.dart';
import 'package:todo_project/uiView/controllers/task_status_mdel.dart';
import 'package:todo_project/uiView/widget/show_snackbar_massage.dart';
import 'package:todo_project/utilities.dart';

class TaskCard extends StatefulWidget {
  final NewtaskModel model;
  final VoidCallback refresh;

  const TaskCard({
    super.key,
    required this.model,
    required this.refresh,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool Inprogress = false;
  bool deleteInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.model.title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.model.description,
              style: const TextStyle(color: Colors.grey),
            ),

            Text(widget.model.createDate),

            Row(
              children: [
                Container(
                  width: 60,
                  height: 25,
                  decoration: BoxDecoration(
                    color: statusColor(widget.model.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      widget.model.status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const Spacer(),

                Visibility(
                  visible:Inprogress == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: IconButton(
                    onPressed: () {
                      changestatus();
                      setState(() {});
                    },
                    icon: const Icon(Icons.edit, color: Colors.grey),
                  ),
                ),

                Visibility(
                  visible:deleteInProgress == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: IconButton(
                    onPressed: () {
                      deleteButton();
                    },
                    icon: const Icon(Icons.delete, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void>  _deleteItem()async{
    deleteInProgress = true;
    setState(() {});

    NetworkResponse response = await Networkcoller().getrequest(Urls.deleteTask(widget.model.id));

    deleteInProgress = false;
    setState(() {});

    if(response.isSuccess){
      widget.refresh();
    }else{
      snakbarMassage(context, response.errormassage.toString());
    }

  }

  void deleteButton(){
    _deleteItem();
  }

  void changestatus() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Change Status"),
          content: Column(
            mainAxisSize: .min,
            children: [
              ListTile(
                title: Text("New"),
                trailing: isCurrentStatus("New") ? Icon(Icons.done) : null,
                onTap: () {
                  handleListTileOntap("New");
                },
              ),
              ListTile(
                title: Text("Progress"),
                trailing: isCurrentStatus("Progress") ? Icon(Icons.done) : null,
                onTap: () {
                  handleListTileOntap("Progress");
                },
              ),
              ListTile(
                title: Text("Cancel"),
                trailing: isCurrentStatus("Cancel") ? Icon(Icons.done) : null,
                onTap: () {
                  handleListTileOntap("Cancel");
                },
              ),
              ListTile(
                title: Text("Complete"),
                trailing: isCurrentStatus("Complete") ? Icon(Icons.done) : null,
                onTap: () {
                  handleListTileOntap("Complete");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool isCurrentStatus(String status) {
    return widget.model.status == status;
  }

  void handleListTileOntap(String status) {
    if (isCurrentStatus(status)) {
      Navigator.pop(context);
    } else {
      _changeStatus(status);
      Navigator.pop(context);
      ;
    }
  }
  Color statusColor(String status){
    switch (status){
      case "New":
      return Colors.blue;
      case "Progress":
        return Colors.amber;
      case "Cancel":
        return Colors.red;
      case "Complete":
        return Colors.green;
      default:
        return Colors.grey;
      }

  }

  Future<void> _changeStatus(String status) async {
    Inprogress = true;
    setState(() {});

    NetworkResponse response = await Networkcoller().getrequest(
      Urls.updateStatus(widget.model.id, status),
    );

    Inprogress = false;
    setState(() {});

    if (response.isSuccess) {
      widget.refresh();
    } else {
      snakbarMassage(context, response.errormassage.toString());
    }
  }
}
