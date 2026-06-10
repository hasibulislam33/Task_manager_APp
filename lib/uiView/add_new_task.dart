import 'package:flutter/material.dart';
import 'package:todo_project/apiclasses/networkclass.dart';
import 'package:todo_project/uiView/widget/TmAppBar.dart';
import 'package:todo_project/uiView/widget/backgroundimage.dart';
import 'package:todo_project/uiView/widget/show_snackbar_massage.dart';
import 'package:todo_project/utilities.dart';

class AddNewTask extends StatefulWidget {

  static final String name = "add_new_task";

  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {

  final _titlecontroller = TextEditingController();
  final _descriptioncontroller = TextEditingController();

  GlobalKey<FormState>  _fromkey = GlobalKey<FormState>();

  bool submitProgress = false;


  Future<void> addNewtask()async{
    submitProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": _titlecontroller.text,
      "description": _descriptioncontroller.text,
      "status": "New Status"
    };

    final NetworkResponse response = await Networkcoller().postrequest(Urls.postreq, requestBody);

    submitProgress = false;
    setState(() {});
    if(response.isSuccess){
      clearTextfield();
      snakbarMassage(context, "New task added");
    }else{
      snakbarMassage(context, "Failed to add new task");
    }
  }

  void clearTextfield(){
    _titlecontroller.clear();
    _descriptioncontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  TmAppbar(enableProfileTap: true,),
      body: background_image(child:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _fromkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),

                Text("Add new task",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                  ),),

                SizedBox(height: 24,),

                TextFormField(
                  controller: _titlecontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Title",
                    helperStyle: TextStyle(
                        color: Colors.grey[400]
                    ),
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return "Enter a title";
                    }else{
                      return null;
                    }
                  },
                ),

                SizedBox(height: 16,),

                TextFormField(
                  controller: _descriptioncontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Description",
                    helperStyle: TextStyle(
                        color: Colors.grey[400]
                    ),
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return "Enter a description";
                    }else{
                      return null;
                    }
                  },
                ),

                SizedBox(height: 24,),

                Visibility(
                  visible: submitProgress == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: FilledButton(onPressed: (){
                    if(_fromkey.currentState!.validate()){
                      setState(() {
                        submitProgress = true;
                      });
                      addNewtask();
                    }
                  }, child: Icon(Icons.arrow_circle_right)),
                )

              ],
            ),
          ),
        ),
      )),
    );
  }
@override
  void dispose() {
    _titlecontroller.dispose();
    _descriptioncontroller.dispose();
    super.dispose();
  }
}

