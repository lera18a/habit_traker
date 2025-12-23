import 'package:habit_traker/data_layer/models/habit.dart';

mixin HabitServiceMixin {
  Future<void> createHabit(Habit habit);
  Future<void> deleteHabit(Habit habit);
  Stream<List<Habit>> get habitsStream;
  Future<void> toggleHabitComplete(bool complete, Habit habit);
  Future<void> loadHabitsAndPush();
}
//пользуюсь репозиторием
