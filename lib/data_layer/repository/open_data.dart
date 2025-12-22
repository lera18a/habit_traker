import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

///В реальном приложении пользователи будут ставить его на чистое устройство,
///где файла БД ещё нет. Тогда нужно, чтобы таблицы создавались из кода — как раз через onCreate.
class OpenData {
  Database? db;

  Future<Database> openBD() async {
    if (db != null) return db!;
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'habits.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE IF NOT EXISTS habits (
            id              INTEGER PRIMARY KEY AUTOINCREMENT,
            name            TEXT    NOT NULL,
            color           INTEGER NOT NULL,
            how_days_habits_do     INTEGER NOT NULL,
            how_much_in_day INTEGER NOT NULL,
            minuts_or_times INTEGER NOT NULL,
            remind          INTEGER NOT NULL,
            time_remind     INTEGER);''');

        await db.execute(
          '''CREATE TABLE IF NOT EXISTS week (
          id        INTEGER PRIMARY KEY AUTOINCREMENT,
            habit_id  INTEGER NOT NULL,
            mon       INTEGER,
            tue       INTEGER,
            wed       INTEGER,
            thu       INTEGER,
            fri       INTEGER,
            sat       INTEGER,
            sun       INTEGER,
            FOREIGN KEY (habit_id) REFERENCES habits(id) ON DELETE CASCADE);''',
        );
      },
    );
    return db!;
  }
}
