import 'package:habit_traker/data_layer/models/habit.dart';
import 'package:habit_traker/data_layer/repository/habit_repository_mixin.dart';
import 'package:sqflite/sqlite_api.dart';

class HabitRepository with HabitRepositoryMixin {
  final Database db;

  HabitRepository({required this.db});

  @override
  Future<void> createHabit(Habit habit) async {
    final habitMap = habit.toHabitMap();
    habitMap.remove('id');
    final habitId = await db.insert(
      'habits',
      habitMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final weekMap = habit.week.toMap(habitId: habitId);

    await db.insert(
      'week',
      weekMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteHabit(Habit habit) async {
    await db.delete('habits', where: 'id = ?', whereArgs: [habit.id]);
  }

  @override
  Stream<List<Habit>> get readHabit async* {
    while (true) {
      final habitRows = await db.query('habits');
      final List<Habit> habits = [];

      for (final h in habitRows) {
        final habitId = h['id'] as int;

        final weekRows = await db.query(
          'week',
          where: 'habit_id = ?',
          whereArgs: [habitId],
          limit: 1,
        );

        if (weekRows.isEmpty) continue;

        final weekMap = weekRows.first;

        habits.add(Habit.fromHabitAndWeekMaps(h, weekMap));
      }

      yield habits;

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    final habitMap = habit.toHabitMap();
    await db.update('habits', habitMap, where: 'id = ?', whereArgs: [habit.id]);

    // Обновляем week
    if (habit.id != null) {
      final weekMap = habit.week.toMap(habitId: habit.id!);
      await db.update(
        'week',
        weekMap,
        where: 'habit_id = ?',
        whereArgs: [habit.id],
      );
    }
  }
}
