part of 'habit_bloc.dart';

@immutable
sealed class HabitEvent {}

final class HabitStartListenEvent extends HabitEvent {}

/// Внутреннее событие: пришли данные из стрима

final class HabitStreamUpdatedEvent extends HabitEvent {
  final List<Habit> habits;

  HabitStreamUpdatedEvent({required this.habits});
}

/// Ошибка из стрима
final class HabitStreamErrorEvent extends HabitEvent {
  final Object error;

  HabitStreamErrorEvent({required this.error});
}

/// Пользовательские интенты
final class HabitCreateHabitEvent extends HabitEvent {
  final Habit habit;

  HabitCreateHabitEvent({required this.habit});
}

final class HabitDeleteHabiEvent extends HabitEvent {
  final Habit habit;

  HabitDeleteHabiEvent({required this.habit});
}

final class HabitToggleHabitCompleteEvent extends HabitEvent {
  final Habit habit;
  final bool complete;

  HabitToggleHabitCompleteEvent({required this.habit, required this.complete});
}
