import 'dart:ffi';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CallModel{

  static Database? _db;

  Future<Database?> get db async{
    if(_db == null){
      _db = await initailDatabase();
      return _db ;
    }else {
      return _db ;
    }
  }

  initailDatabase() async {
    String defultPath = await getDatabasesPath();
    String path = join(defultPath , 'callingData.db'); //  data/data/callingData.db
    Database mydb = await openDatabase(path , onCreate: createDatabase , version: 1, onUpgrade: upgradeDatabase);
  }


  upgradeDatabase(Database db , int oldVersion , int newVersion) async {

    print("onUpgrade ========================");
  }

  createDatabase(Database db , int version) async {

    db.execute(
        '''
    CREATE TABLE 'users' (
       'id' INTEGER PRIMARY KEY AUTOINCREMENT,
       'name' TEXT NOT NULL ,
       'phone' TEXT NOT NULL ,
       'email' TEXT NOT NULL
     )
    ''');
    print("onCreate ========================");
  }

  deleteMyDatabase() async {
    String defultPath = await getDatabasesPath();
    String path = join(defultPath , 'callingData.db');
    await deleteDatabase(path);
  }

  readRaw(sql) async {
    Database? data = await db ;
     List<Map> response = await data!.rawQuery(sql);
     return response ;
  }

  insertRaw(sql) async {
    Database? data = await db ;
    int response = await data!.rawInsert(sql);
    return response ;
  }

  updateRaw(sql) async {
    Database? data = await db ;
    int response = await data!.rawUpdate(sql);
    return response ;
  }

  deleteRaw(sql) async {
    Database? data = await db ;
    int response = await data!.rawDelete(sql);
    return response ;
  }






  // built in functions (no SQL code)

  read(String table) async {
    Database? data = await db ;
    List<Map> response = await data!.query(table);
    return response ;
  }

  insert(String table , Map<String, Object?> values) async {
    Database? data = await db ;
    int response = await data!.insert(table, values);
    return response ;
  }

  update(String table , Map<String, Object?> values , String mywhere) async {
    Database? data = await db ;
    int response = await data!.update(table, values , where: mywhere);
    return response ;
  }

  delete(String table , String mywhere) async {
    Database? data = await db ;
    int response = await data!.delete(table , where: mywhere);
    return response ;
  }
}
