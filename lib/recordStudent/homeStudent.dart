import 'package:flutter/material.dart';
import 'package:sqlflite/recordStudent/addStudent.dart';
import 'package:sqlflite/recordStudent/editStudent.dart';
import 'package:sqlflite/recordStudent/sqlfliteDB.dart';

class HomeStudent extends StatefulWidget {
  const HomeStudent({super.key});

  @override
  State<HomeStudent> createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent> {
  List<Map> students = [];
  Model model = Model();

  Future<List<Map>?> getdata () async{
    //List<Map> response = await model.read("student");
    List<Map> response = await model.readData("SELECT * FROM 'student'");
    students.addAll(response);
    setState(() {

    });
  }

  @override
  void initState() {
     getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add , color: Colors.white,),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddStudent()));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(color: Colors.white),
        title:  Text("Students"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
          //     MaterialButton(
          //       color: Colors.blue,
          //       child: Text("delete database"),
          //       textColor: Colors.white,
          //       onPressed: () async{
          //         await model.mydeleteDatabase();
          //       },
          //     ),
          //   ],
          // ),
          // SizedBox(height: 15,),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: students.length,
            itemBuilder: (context , i){
              return Card(
                child: ListTile(
                  leading: Text("${students[i]['id']}"),
                  title: Text("${students[i]['name']}" , style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text("${students[i]['grade']}" , style: TextStyle(fontSize: 12)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.green,),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditStudent(name: "${ students[i]['name']}", grade: "${ students[i]['grade']}" , activity: "${ students[i]['activity']}", id: "${ students[i]['id']}",)));
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.delete_rounded , color: Colors.red,),
                        onPressed: () async {
                          int response = await model.delete("student", "id = ${students[i]['id']}");
                          // int response = await model.deleteData("DELETE FROM 'student' WHERE id = ${students[i]['id']}");
                          students.removeWhere((element) => element['id'] == students[i]['id']);
                          setState(() {

                          });
                        },
                      ),
                    ],
                  )
                ),
              );
            },
          ),
        ],
      ),
    ]));
  }
}
