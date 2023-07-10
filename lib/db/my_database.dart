import 'package:database_app/model/database_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MainDataBase {
  MainDataBase._init();

  static MainDataBase instance = MainDataBase._init();
  static Database? database;

  Future<Database?> getDatabase() async {
    if (database != null) {
      return database;
    } else {
      database = await createDataBase("my_mht");
      return database;
    }
  }

  Future<Database> createDataBase(String databaseName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        const String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
        const String textType = "TEXT NOT NULL";
        const String digitType = "INTEGER NOT NULL";

        await db.execute('''
              CREATE TABLE $tableName(
                ${FiledDb.id} $idType,
                ${FiledDb.code} $digitType,
                ${FiledDb.fName} $textType,
                ${FiledDb.lName} $textType
              )
      ''');
      },
    );
  }

  Future<List<MainModel>> getAll() async {
    final db = await MainDataBase.instance.getDatabase();
    final result = await db!.query(tableName);
    return List<MainModel>.from(
      result.map(
        (v) => MainModel.fromJson(v),
      ),
    );
  }

  Future<MainModel> getById(int? id) async {
    final db = await MainDataBase.instance.getDatabase();
    final result = await db!.query(
      tableName,
      columns: FiledDb.allValues,
      where: "${FiledDb.id} = ?",
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return MainModel.fromJson(result.first);
    } else {
      throw Exception("Can't load data");
    }
  }

  Future<MainModel> sendData(MainModel model) async {
    final db = await MainDataBase.instance.getDatabase();
    final result = await db!.insert(
      tableName,
      model.toJson(),
    );
    return model.copy(id: result);
  }

  Future<int> updateData(MainModel model) async {
    final db = await MainDataBase.instance.getDatabase();
    final result = await db!.update(
      tableName,
      model.toJson(),
      where: "${FiledDb.id} = ?",
      whereArgs: [model.id],
    );
    return result;
  }

  Future<int> deleteData(int? id) async {
    final db = await MainDataBase.instance.getDatabase();
    final result = await db!.delete(
      tableName,
      where: "${FiledDb.id} = ?",
      whereArgs: [id],
    );
    return result;
  }

  Future closeDatabase() async {
    final db = await MainDataBase.instance.getDatabase();
    await db!.close();
  }
}
