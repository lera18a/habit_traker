//один к одному
// CRUD
import 'package:habit_traker/data_layer/models/habit.dart';

mixin HabitRepositoryMixin {
  Future<void> createHabit(Habit habit);
  Future<List<Habit>> get readHabit;
  Future<void> updateHabit(Habit habit);
  Future<void> deleteHabit(Habit habit);
}
