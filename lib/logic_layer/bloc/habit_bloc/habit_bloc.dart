import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:habit_traker/data_layer/models/habit.dart';
import 'package:habit_traker/logic_layer/service/habit_service_mixin.dart';

part 'habit_event.dart';
part 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitServiceMixin habitService;
  StreamSubscription<List<Habit>>? _subscription;
  HabitBloc({required this.habitService}) : super(HabitLoadingState()) {
    on<HabitStartListenEvent>(_onHabitStartListenEvent);
    on<HabitStreamUpdatedEvent>(_onHabitStreamUpdatedEvent);
    on<HabitStreamErrorEvent>(_onHabitStreamErrorEvent);
    on<HabitCreateEvent>(_onHabitCreateHabitEvent);
    on<HabitDeleteEvent>(_onHabitDeleteHabiEvent);
    on<HabitToggleCompleteEvent>(_onHabitToggleHabitCompleteEvent);

    add(HabitStartListenEvent());
  }
  // add(HabitStartListenEvent);

  /// Запуск подписки на стрим сервиса
  Future<void> _onHabitStartListenEvent(
    HabitStartListenEvent event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoadingState());

    // Подписываемся на поток привычек
    _subscription = habitService.habitsStream.listen(
      (habits) {
        add(HabitStreamUpdatedEvent(habits: habits));
      },
      onError: (error) {
        add(HabitStreamErrorEvent(error: error));
      },
    );

    // Первичная загрузка
    try {
      await habitService.loadHabitsAndPush();
    } catch (e) {
      emit(HabitLoadingFailedState(message: e.toString()));
    }
  }

  void _onHabitStreamUpdatedEvent(
    HabitStreamUpdatedEvent event,
    Emitter<HabitState> emit,
  ) {
    emit(HabitLoadedSuccessState(habits: event.habits));
  }

  void _onHabitStreamErrorEvent(
    HabitStreamErrorEvent event,
    Emitter<HabitState> emit,
  ) {
    emit(HabitLoadingFailedState(message: event.error.toString()));
  }

  Future<void> _onHabitCreateHabitEvent(
    HabitCreateEvent event,
    Emitter<HabitState> emit,
  ) async {
    await habitService.createHabit(event.habit);
    // поток сам обновится → придёт TodayStreamUpdated
  }

  Future<void> _onHabitDeleteHabiEvent(
    HabitDeleteEvent event,
    Emitter<HabitState> emit,
  ) async {
    await habitService.deleteHabit(event.habit);
  }

  Future<void> _onHabitToggleHabitCompleteEvent(
    HabitToggleCompleteEvent event,
    Emitter<HabitState> emit,
  ) async {
    await habitService.toggleHabitComplete(event.complete, event.habit);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    habitService.dispose();
    return super.close();
  }
}
