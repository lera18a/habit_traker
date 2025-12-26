part of 'habit_bloc.dart';

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
final class HabitCreateEvent extends HabitEvent {
  final Habit habit;

  HabitCreateEvent({required this.habit});
}

final class HabitDeleteEvent extends HabitEvent {
  final Habit habit;

  HabitDeleteEvent({required this.habit});
}

final class HabitToggleCompleteEvent extends HabitEvent {
  final Habit habit;
  final bool complete;

  HabitToggleCompleteEvent({required this.habit, required this.complete});
}
