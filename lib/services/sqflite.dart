import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _dataVersion = 1;
  static final table = "table";
  static final columnId = "id";
  static final columntitle = "birdName";
  static final columnDescription = "birdDescription";
  static final columnUrl = "url";
  static final longitude = "longitude";
  static final latitude = "latitude";

  //Create Singletone
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  factory DatabaseHelper() {
    return instance;
  }
  // Only one app-wide reference to database
  static Database? _database;

  Future<Database?> get database async {
    if (database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path, version: _dataVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database database, int version) async {
    await database.execute("""
      CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY,
      $columntitle TEXT NOT NULL,
      $columnDescription TEXT NOT NULL,
      $columnUrl TEXT NOT NULL,
      $latitude REAL NOT NULL,
      $longitude REAL NOT NULL )
      """);

    Future<int?> insert(Map<String, dynamic> row) async {
      Database? db = await instance.database;
      return await db!.insert(table, row);
    }

    Future<List<Map<String, dynamic>>> qureyAllRows() async {
      Database? db = await instance.database;
      return await db!.query(table);
    }

    delete(int, id) async {
      Database? db = await instance.database;
      return await db!.delete(table, where: "$columnId = ?", whereArgs: [id]);
    }
  }
}
