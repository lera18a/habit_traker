import 'package:flutter/material.dart';
import 'package:habit_traker/data_layer/repository/create_data.dart';
import 'package:habit_traker/habit_traker_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await createData();
  runApp(HabitTrakerApp(db: db));
}
