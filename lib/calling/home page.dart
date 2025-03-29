import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlflite/recordStudent/sqlfliteDB.dart';

import 'callmodel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey <FormState> formkey = GlobalKey();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();


  CallModel callmode = CallModel();
  Model model = Model() ;
  List<Map> callUsers= [];

   getData() async {
    List<Map> response = await model.readData("SELECT * FROM 'users'");
    callUsers.addAll(response);
    setState(() {

    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        child: Icon(Icons.add , color: Colors.black,),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                      child: Text("add" , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      onPressed: () async {
                        int response = await model.insertData("INSERT INTO 'users' ('name' , 'phone' , 'email' ) VALUES ('${namecontroller.text}' , '${phonecontroller.text}' , '${emailcontroller.text}')");
                        print(response);
                        if(response > 0){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
                        }
                      },
                    ),
                    TextButton(
                      child: Text("cancel" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  title: Text("Add User" , style: TextStyle(fontWeight: FontWeight.bold),),
                  content: Form(
                    key: formkey,
                    child: Container(
                      height: 200,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: namecontroller,
                            decoration: InputDecoration(
                              hintText: "name",
                            ),
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: phonecontroller,
                            decoration: InputDecoration(
                              hintText: "phone",
                            ),
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: emailcontroller,
                            decoration: InputDecoration(
                              hintText: "email",
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 19,fontWeight: FontWeight.bold),
        title:  Text("Calling"),
      ),
      body: ListView(
        children: [
          // MaterialButton(
          //   child: Text("delete database"),
          //     onPressed: () async {
          //   await model.mydeleteDatabase();
          // }),
          // SizedBox(height: 40,),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: callUsers.length,
            itemBuilder: (context,i){
              return Card(
                child: ListTile(
                  leading: Container(
                    child: Center(
                        child: Text(
                          "${callUsers[i]['name'][0]}",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),)),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(70),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person , color: Colors.black,size: 16,),
                          SizedBox(width: 10,),
                          Text("${callUsers[i]['name']}" , style: TextStyle(fontSize: 13),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.phone , color: Colors.black,size: 16,),
                          SizedBox(width: 10,),
                          Text("${callUsers[i]['phone']}" , style: TextStyle(fontSize: 13),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.email , color: Colors.black,size: 16,),
                          SizedBox(width: 10,),
                          Text("${callUsers[i]['email']}" , style: TextStyle(fontSize: 13),),
                        ],
                      ),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.green,),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    actions: [
                                      TextButton(
                                        child: Text("edit" , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                        onPressed: () async {
                                          int response = await model.updateData("UPDATE 'users' SET 'name' = '${namecontroller.text}' , 'phone' = '${phonecontroller.text}' , 'email' = '${emailcontroller.text}' WHERE id = ${callUsers[i]['id']}");
                                          print(response);
                                          if(response > 0){
                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
                                          }
                                        },
                                      ),
                                      TextButton(
                                        child: Text("cancel" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                    title: Text("Edit User" , style: TextStyle(fontWeight: FontWeight.bold),),
                                    content: Form(
                                      key: formkey,
                                      child: Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: namecontroller,
                                              decoration: InputDecoration(
                                                hintText: "name",
                                              ),
                                            ),
                                            SizedBox(height: 15,),
                                            TextFormField(
                                              controller: phonecontroller,
                                              decoration: InputDecoration(
                                                hintText: "phone",
                                              ),
                                            ),
                                            SizedBox(height: 15,),
                                            TextFormField(
                                              controller: emailcontroller,
                                              decoration: InputDecoration(
                                                hintText: "email",
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15,),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red,),
                          onPressed: () async {
                            int response = await model.deleteData("DELETE FROM 'users' WHERE id = ${callUsers[i]['id']}");
                            if(response > 0){
                              callUsers.removeWhere((element) => element['id'] == callUsers[i]['id'] );
                              setState(() {
                                
                              });
                              //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
                            }
                          },
                        ),
                      )
                    ],
                  )
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

