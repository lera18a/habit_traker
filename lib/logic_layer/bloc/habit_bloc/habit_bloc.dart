import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:habit_traker/data_layer/models/habit.dart';
import 'package:habit_traker/logic_layer/service/habit_service.dart';

part 'habit_event.dart';
part 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitService _habitService;
  StreamSubscription<List<Habit>>? _subscription;
  HabitBloc(this._habitService) : super(HabitLoadingState()) {
    on<HabitStartListenEvent>(_onHabitStartListenEvent);
    on<HabitStreamUpdatedEvent>(_onHabitStreamUpdatedEvent);
    on<HabitStreamErrorEvent>(_onHabitStreamErrorEvent);
    on<HabitCreateHabitEvent>(_onHabitCreateHabitEvent);
    on<HabitDeleteHabiEvent>(_onHabitDeleteHabiEvent);
    on<HabitToggleHabitCompleteEvent>(_onHabitToggleHabitCompleteEvent);
  }

  /// Запуск подписки на стрим сервиса
  Future<void> _onHabitStartListenEvent(
    HabitStartListenEvent event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoadingState());

    // Подписываемся на поток привычек
    _subscription = _habitService.habitsStream.listen(
      (habits) {
        add(HabitStreamUpdatedEvent(habits: habits));
      },
      onError: (error) {
        add(HabitStreamErrorEvent(error: error));
      },
    );

    // Первичная загрузка
    try {
      await _habitService.loadHabitsAndPush();
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
    HabitCreateHabitEvent event,
    Emitter<HabitState> emit,
  ) async {
    await _habitService.createHabit(event.habit);
    // поток сам обновится → придёт TodayStreamUpdated
  }

  Future<void> _onHabitDeleteHabiEvent(
    HabitDeleteHabiEvent event,
    Emitter<HabitState> emit,
  ) async {
    await _habitService.deleteHabit(event.habit);
  }

  Future<void> _onHabitToggleHabitCompleteEvent(
    HabitToggleHabitCompleteEvent event,
    Emitter<HabitState> emit,
  ) async {
    await _habitService.toggleHabitComplete(event.complete, event.habit);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _habitService.dispose();
    return super.close();
  }
}
