import 'package:my_house/models/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
class HouseManager{
    
    static Database _database;
    Future<Database> get database async{
      if(_database!=null)
      return _database;

      _database= await openDb();
      return _database;
    }
  openDb()async {
    try{
      io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "house_db.db");
 return await openDatabase(
    //join(path,'house_db.db'),
    path,
    onCreate: (db,version){
      return db.execute(
        "CREATE TABLE house(id INTEGER PRIMARY KEY AUTOINCREMENT,name text,address text,area INTEGER,qty INTEGER,rate INTEGER,tax INTEGER,remark TEXT)"
        );
    },
    version: 2
  );
    }catch(e){
      throw e;
    }
    
  }

  Future<void> insertHouse(Home house) async {
  // Get a reference to the database.
  final Database db = await database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'house',
    house.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  }
  
  Future<List<Home>> homeList()async{
    final Database db=await database;
    final List<Map<String, dynamic>> maps = await db.query('house');
    return maps.map(
            (dynamic item) => Home.fromJson(item),
          )
          .toList();
  }
  Future<void> deleteDog(int id) async {
  // Get a reference to the database.
  final db = await database;

  // Remove the Dog from the Database.
  await db.delete(
    'house',
    // Use a `where` clause to delete a specific dog.
    where: "id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

}