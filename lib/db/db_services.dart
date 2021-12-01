import 'package:my_todo/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbServices {
  static String tabelName = 'tasks';
  static Database? db;
  static int version = 1;
  static Future<void> init() async {
    if (db != null) {
      print('db is not null');
      return;
    } else {
      try {
        String databasesPath = await getDatabasesPath();
        String path = join(databasesPath, tabelName);
        db = await openDatabase(
          path,
          version: version,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
              'CREATE TABLE $tabelName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title STRING, note TEXT, date STRING, isCompleted INTEGER, '
              'startTime STRING, endTime STRING, '
              'remind INTEGER, repeat STRING, '
              'color INTEGER)',
            );
          },
        );
        print('Done DB.init() Successfully');
      } catch (e) {
        print(e);
      }
      print('DB is : $db');
    }
  }

  static Future<int> insert(Task task) async {
    print('Inserting Task to DataBase');
    print('DB is : $db');
    return db!.insert(tabelName, task.toJson());
  }

  static Future<int> delete(int id) async {
    print('Deleting Task from DataBase');
    return db!.delete(tabelName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> update(Task task) async {
    print('Updating Task in DataBase');
    return db!.update(
      tabelName,
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> complete(Task task) async {
    print('Completing Task in DataBase');
    return db!.rawUpdate(
      '''
    UPDATE $tabelName
    SET isCompleted = ?
    WHERE id = ?
    ''',
      [
        task.isCompleted == 0 ? 1 : 0,
        task.id,
      ],
    );
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('Querying about DataBase');
    return db!.query(tabelName);
  }
}
