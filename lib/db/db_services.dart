import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbServices {
  static String tabelName = 'task.db';
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
        Database database = await openDatabase(
          path,
          version: version,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
                'CREATE TABLE $tabelName (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT, date STRING, startTime STRING, endTime STRING, remind INTEGER, repeat STRING, color INTEGER, isComplete INTEGER)');
          },
        );
        print('Done DB.init() Successfully');
      } catch (e) {
        print(e);
      }
    }
  }
}
