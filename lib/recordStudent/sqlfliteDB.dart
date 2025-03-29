import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Model {

  static Database? _db;

  Future<Database?> get db async{
    if(_db == null){
      _db = await createDatabase();
      return _db ;
    }else {
      return _db ;
    }
  }

  createDatabase() async{
   String defaulter =  await getDatabasesPath(); // defaulter path
   String path = await join(defaulter , "data.db");  // data/data/data.db (database location)
   Database mydb = await openDatabase(path , onCreate: Create , version: 11 , onUpgrade: Upgrade);
   return mydb ;
  }

  Upgrade(Database db , int oldversion , int newversion) async{
   // await db.execute("ALTER TABLE 'student' ADD COLUMN 'activity' TEXT ");
   // await db.execute("ALTER TABLE 'student' MODIFY COLUMN grade INTEGER");
    print("OnUpgrade==============");
    // execute when the version changed
  }

  Create(Database db , int version) async{

    Batch batch = db.batch();

    batch.execute(
        '''
    CREATE TABLE 'users' (
       'id' INTEGER PRIMARY KEY AUTOINCREMENT,
       'name' TEXT NOT NULL ,
       'phone' TEXT NOT NULL ,
       'email' TEXT NOT NULL
     )
    ''');
    batch.execute('''
     CREATE TABLE 'manager' (
       'id' INTEGER PRIMARY KEY AUTOINCREMENT,
       'name' TEXT NOT NULL,
       'position' REAL NOT NULL
     )
    ''');

    await batch.commit();

    print("OnCreate=============="); // execute one time only
  }

  // read data

  readData(sql) async{
    Database? dataBase = await db ;
    List<Map> response = await dataBase!.rawQuery(sql);
    return response ;
  }

  // insert data

  insertData(sql) async{
    Database? database = await db ;
    int response = await database!.rawInsert(sql);
    return response ;
  }

  // update data

  updateData(sql) async{
    Database? database = await db ;
    int response = await database!.rawUpdate(sql);
    return response ;
  }

  // delete data

  deleteData(sql) async{
    Database? database = await db ;
    int response = await database!.rawDelete(sql);
    return response ;
  }

  mydeleteDatabase() async{
    String defaulter =  await getDatabasesPath();
    String path = await join(defaulter , "data.db");
    await deleteDatabase(path);
  }




  read(String table) async{
    Database? dataBase = await db ;
    List<Map> response = await dataBase!.query(table);
    return response ;
  }


  insert(String table , Map<String, Object?> values) async{
    Database? database = await db ;
    int response = await database!.insert(table , values);
    return response ;
  }

  // update data

  update(String table ,  Map<String, Object?> values , String conwhere) async{
    Database? database = await db ;
    int response = await database!.update(table , values , where: conwhere);
    return response ;
  }

  // delete data

  delete(String table , String conwhere) async{
    Database? database = await db ;
    int response = await database!.delete(table , where: conwhere);
    return response ;
  }
}