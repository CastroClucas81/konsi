import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    return await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'konsi.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_adresses);
  }

  String get _adresses => '''
    CREATE TABLE adresses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      cep VARCHAR(255),
      street VARCHAR(255),
      district VARCHAR(255),
      city VARCHAR(255),
      uf VARCHAR(255)
    )
  '''; 
}
