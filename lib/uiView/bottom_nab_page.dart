import 'package:flutter/material.dart';
import 'package:todo_project/uiView/complete_task_list.dart';
import 'package:todo_project/uiView/new_task_list.dart';
import 'package:todo_project/uiView/progress_task_list.dart';
import 'package:todo_project/uiView/widget/TmAppBar.dart';
import 'package:todo_project/uiView/cancel_task_list.dart';


class BottomNabPage extends StatefulWidget {
  const BottomNabPage({super.key});

  static final String name = "bottom_home_page";

  @override
  State<BottomNabPage> createState() => _BottomNabPageState();
}

class _BottomNabPageState extends State<BottomNabPage> {

  int currenindex = 0;

  final List<Widget> pages = [
    NewTaskList(),
    ProgressTaskList(),
    CancelTaskList(),
    CompleteTaskList()

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(enableProfileTap: true,),
      body: pages[currenindex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currenindex,
          onDestinationSelected: (int index){
          setState(() {
            currenindex = index;
          });
          },
          destinations:
      [
        NavigationDestination(
            icon: Icon(Icons.home), label: "Home"),

        NavigationDestination(
            icon: Icon(Icons.run_circle), label: "progress"),

        NavigationDestination(
            icon: Icon(Icons.cancel), label: "cancel"),

        NavigationDestination(
            icon: Icon(Icons.done), label: "complete"),
      ]
      ),
    );
  }
}


