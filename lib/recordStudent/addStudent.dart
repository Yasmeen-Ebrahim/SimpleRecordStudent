import 'package:flutter/material.dart';
import 'package:sqlflite/recordStudent/homeStudent.dart';
import 'package:sqlflite/recordStudent/sqlfliteDB.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  Model model = Model();
  GlobalKey<FormState> formKey =  GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController activityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(color: Colors.white),
        title:  Text("add student"),
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
                child: Text("add"),
                textColor: Colors.white,
                onPressed: () async{
                  int response = await model.insert(
                      "student", {
                    "name" : "${nameController.text}" ,
                    "grade" : "${gradeController.text}" ,
                    "activity" : "${activityController.text}" ,
                  });
                  // int response = await model.insertData(
                  //     "INSERT INTO 'student' ('name' , 'grade' , 'activity') VALUES ('${nameController.text}' , '${gradeController.text}' , '${activityController.text}' )");
                  if(response > 0){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeStudent()), (route) => false);
                  }
                },
              ),
            ],
          ),
          ],
        ),
      );
  }
}
