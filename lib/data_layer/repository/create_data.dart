import 'package:habit_traker/data_layer/repository/open_data.dart';
import 'package:sqflite/sqlite_api.dart';

Future<Database> createData() async {
  final openData = OpenData();
  final db = await openData.openBD();
  await db.execute('PRAGMA foreign_keys = ON;');
  return db;
}
