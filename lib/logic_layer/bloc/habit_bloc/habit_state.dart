part of 'habit_bloc.dart';

sealed class HabitState {}

final class HabitLoadingState extends HabitState {}

final class HabitLoadedSuccessState extends HabitState {
  final List<Habit> habits;

  HabitLoadedSuccessState({required this.habits});
}

final class HabitLoadingFailedState extends HabitState {
  final String message;

  HabitLoadingFailedState({required this.message});
}
