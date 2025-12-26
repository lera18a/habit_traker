import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

import 'package:habit_traker/data_layer/models/habit.dart';
import 'package:habit_traker/data_layer/models/week.dart';
import 'package:habit_traker/data_layer/repository/habit_repository.dart';

import 'test_db.dart';

void main() {
  late Database db;
  late HabitRepository repository;

  Habit buildHabit({int? id}) {
    return Habit(
      id: id,
      name: 'Drink water',
      color: 0xFF00FF00,
      howDaysHabitsDo: 30,
      howMuchInDay: 5,
      minutsOrTimes: MinutsOrTimes.times,
      remind: true,
      timeRemind: DateTime(2025, 1, 1, 8, 0),
      week: Week(
        mon: true,
        tue: true,
        wed: true,
        thu: true,
        fri: true,
        sat: false,
        sun: false,
      ),
    );
  }

  setUp(() async {
    db = await openTestDatabase();
    repository = HabitRepository(db: db);
  });

  tearDown(() async {
    await db.close();
  });

  test('createHabit создаёт запись в habits и week', () async {
    final habit = buildHabit();

    await repository.createHabit(habit);

    final habitsRows = await db.query('habits');
    final weekRows = await db.query('week');

    expect(habitsRows.length, 1);
    expect(weekRows.length, 1);

    final h = habitsRows.first;
    final w = weekRows.first;

    expect(h['name'], 'Drink water');
    expect(h['color'], 0xFF00FF00);
    expect(h['how_days_habits_do'], 30);
    expect(h['how_much_in_day'], 5);
    expect(h['minuts_or_times'], MinutsOrTimes.times.index);
    expect(h['remind'], 1);
    expect(h['time_remind'], isNotNull);

    expect(w['habit_id'], h['id']);
    expect(w['mon'], 1);
    expect(w['sat'], 0);
  });

  test('deleteHabit удаляет привычку, week удалится каскадно', () async {
    final habit = buildHabit();
    await repository.createHabit(habit);

    final habitsBefore = await db.query('habits');
    final weeksBefore = await db.query('week');
    expect(habitsBefore.length, 1);
    expect(weeksBefore.length, 1);

    final habitId = habitsBefore.first['id'] as int;
    final habitForDelete = buildHabit(id: habitId);

    await repository.deleteHabit(habitForDelete);

    final habitsAfter = await db.query('habits');
    final weeksAfter = await db.query('week');

    expect(habitsAfter.length, 0);
    expect(weeksAfter.length, 0); // этот assert сейчас и падает
  });

  test('updateHabit обновляет и habits, и week', () async {
    final habit = buildHabit();
    await repository.createHabit(habit);

    final habitsRows = await db.query('habits');
    final habitId = habitsRows.first['id'] as int;

    final updatedHabit = Habit(
      id: habitId,
      name: 'Drink water updated',
      color: 0xFFFF0000,
      howDaysHabitsDo: 60,
      howMuchInDay: 10,
      minutsOrTimes: MinutsOrTimes.minuts,
      remind: false,
      timeRemind: null,
      week: Week(
        mon: false,
        tue: false,
        wed: true,
        thu: true,
        fri: true,
        sat: true,
        sun: true,
      ),
    );

    await repository.updateHabit(updatedHabit);

    final habitsAfter = await db.query('habits');
    final weekAfter = await db.query('week');

    final h = habitsAfter.first;
    final w = weekAfter.first;

    expect(h['name'], 'Drink water updated');
    expect(h['color'], 0xFFFF0000);
    expect(h['how_days_habits_do'], 60);
    expect(h['how_much_in_day'], 10);
    expect(h['minuts_or_times'], MinutsOrTimes.minuts.index);
    expect(h['remind'], 0);
    expect(h['time_remind'], isNull);

    expect(w['habit_id'], habitId);
    expect(w['mon'], 0);
    expect(w['wed'], 1);
    expect(w['sun'], 1);
  });

  test('readHabit стримит список привычек из habits + week', () async {
    await repository.createHabit(buildHabit());
    await repository.createHabit(buildHabit());
    await repository.createHabit(buildHabit());

    final stream = repository.readHabit;
    final habits = await stream;

    expect(habits.length, 3);
    for (final h in habits) {
      expect(h.name, 'Drink water');
      expect(h.week.mon, true);
      expect(h.color, 0xFF00FF00);
      expect(h.howMuchInDay, 5);
      expect(h.minutsOrTimes, MinutsOrTimes.times);
    }
  });

  test(
    'Habit.toHabitMap и Habit.fromHabitAndWeekMaps корректно мапят данные',
    () async {
      final habit = buildHabit(id: 10);
      final habitMap = habit.toHabitMap();
      final weekMap = habit.week.toMap(habitId: 10);

      final restoredHabit = Habit.fromHabitAndWeekMaps(habitMap, weekMap);

      expect(restoredHabit.id, habit.id);
      expect(restoredHabit.name, habit.name);
      expect(restoredHabit.color, habit.color);
      expect(restoredHabit.howDaysHabitsDo, habit.howDaysHabitsDo);
      expect(restoredHabit.howMuchInDay, habit.howMuchInDay);
      expect(restoredHabit.minutsOrTimes, habit.minutsOrTimes);
      expect(restoredHabit.remind, habit.remind);
      expect(restoredHabit.timeRemind, habit.timeRemind);
      expect(restoredHabit.week.mon, habit.week.mon);
      expect(restoredHabit.week.sun, habit.week.sun);
    },
  );
}
