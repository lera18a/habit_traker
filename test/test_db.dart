import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> openTestDatabase() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final db = await openDatabase(
    inMemoryDatabasePath,
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

      // здесь уже включили Foreign Keys
      await db.execute('PRAGMA foreign_keys = ON;');
    },
  );

  // и ещё раз на всякий случай после открытия
  await db.execute('PRAGMA foreign_keys = ON;');
  return db;
}
