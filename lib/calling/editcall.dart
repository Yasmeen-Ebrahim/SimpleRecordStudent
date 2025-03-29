import 'package:flutter/material.dart';
import 'package:sqlflite/recordStudent/homeStudent.dart';
import 'package:sqlflite/recordStudent/sqlfliteDB.dart';

class EditCall extends StatefulWidget {
  final String name ;
  final String grade ;
  final String activity ;
  final String id ;
  const EditCall({super.key, required this.name, required this.grade, required this.activity, required this.id,});

  @override
  State<EditCall> createState() => _EditCallState();
}

class _EditCallState extends State<EditCall> {
  Model model = Model();
  GlobalKey<FormState> formKey =  GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController activityController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.name ;
    gradeController.text = widget.grade ;
    activityController.text = widget.activity ;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(color: Colors.white),
        title:  Text("edit student"),
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelText: "Name"
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: gradeController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelText: "Grade"
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: activityController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        labelText: "Activity"
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 40,),
          Column(
            children: [
              MaterialButton(
                  color: Colors.blue,
                  child: Text("edit"),
                  textColor: Colors.white,
                  onPressed: () async{
                    int response = await model.update(
                        "student", {
                      "name" : "${nameController.text}",
                      "grade" : "${gradeController.text}",
                      "activity" : "${activityController.text}",
                    }, "id =  ${widget.id}");
                    // int response = await model.updateData('''
                    // UPDATE 'student' SET
                    // 'name' = "${nameController.text}" ,
                    // 'grade' = ${gradeController.text},
                    // 'activity' = "${activityController.text}"
                    // WHERE id = ${widget.id}
                    // ''');
                    if(response > 0){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeStudent()), (route) => false);
                    }
                  }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
