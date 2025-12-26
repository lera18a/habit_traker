import 'package:flutter/material.dart';
import 'package:habit_traker/data_layer/repository/habit_repository.dart';
import 'package:habit_traker/data_layer/repository/habit_repository_mixin.dart';
import 'package:habit_traker/logic_layer/service/habit_service.dart';
import 'package:habit_traker/logic_layer/service/habit_service_mixin.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

class InjectorWidget extends StatelessWidget {
  const InjectorWidget({super.key, required this.child, required this.db});
  final Widget child;
  final Database db;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HabitRepositoryMixin>(
          create: (context) => HabitRepository(db: db),
        ),
        Provider<HabitServiceMixin>(
          create: (context) => HabitService(context.read()),
        ),
      ],
      child: child,
    );
  }
}
