import 'package:flutter/material.dart';
import 'package:habit_traker/navigation/app_router.dart';
import 'package:habit_traker/widget/bloc/bloc_injector_widget.dart';
import 'package:habit_traker/widget/di/injector_widget.dart';
import 'package:sqflite/sqflite.dart';

//сюда DI - InjectorWidget. !!!!!
//bloc - BlocInjectorWidget
//роутер !!!!
//локализация
//материал апп !!!!
final appRouter = AppRouter();

class HabitTrakerApp extends StatelessWidget {
  const HabitTrakerApp({super.key, required this.db});
  final Database db;
  @override
  Widget build(BuildContext context) {
    return InjectorWidget(
      db: db,
      child: BlocInjectorWidget(
        child: MaterialApp.router(routerConfig: appRouter.config()),
      ),
    );
  }
}
