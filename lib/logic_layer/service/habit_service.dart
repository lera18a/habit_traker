import 'dart:async';

import 'package:habit_traker/data_layer/models/habit.dart';
import 'package:habit_traker/data_layer/repository/habit_repository_mixin.dart';
import 'package:habit_traker/logic_layer/service/habit_service_mixin.dart';

class HabitService with HabitServiceMixin {
  final HabitRepositoryMixin repository;
  final habitContrroller = StreamController<List<Habit>>.broadcast();

  HabitService(this.repository);

  @override
  Future<void> createHabit(Habit habit) async {
    await repository.createHabit(habit);
    await loadHabitsAndPush();
  }

  @override
  Future<void> deleteHabit(Habit habit) async {
    await repository.deleteHabit(habit);
    await loadHabitsAndPush();
  }

  @override
  Stream<List<Habit>> get habitsStream => habitContrroller.stream;

  @override
  Future<void> loadHabitsAndPush() async {
    final habits = await repository.readHabit.first;
    habitContrroller.add(habits);
  }

  @override
  Future<void> toggleHabitComplete(bool complete, Habit habit) async {
    await loadHabitsAndPush();
  }

  void dispose() {
    habitContrroller.close();
  }
}
