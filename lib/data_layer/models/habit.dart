import 'package:habit_traker/data_layer/models/week.dart';

enum MinutsOrTimes { times, minuts }

class Habit {
  final int? id;
  final String name;
  final int color;
  final int howDaysHabitsDo;
  final int howMuchInDay;
  final MinutsOrTimes minutsOrTimes;
  final bool remind;
  final DateTime? timeRemind;
  final Week week;

  Habit({
    required this.id,
    required this.name,
    required this.howDaysHabitsDo,
    required this.howMuchInDay,
    required this.minutsOrTimes,
    required this.remind,
    required this.timeRemind,
    required this.week,
    required this.color,
  });

  Map<String, dynamic> toHabitMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'how_days_habits_do': howDaysHabitsDo,
      'how_much_in_day': howMuchInDay,
      'minuts_or_times': minutsOrTimes.index,
      'remind': remind ? 1 : 0,
      'time_remind': timeRemind?.millisecondsSinceEpoch,
    };
  }

  factory Habit.fromHabitAndWeekMaps(
    Map<String, dynamic> habitMap,
    Map<String, dynamic> weekMap,
  ) {
    return Habit(
      id: habitMap['id'] as int,
      name: habitMap['name'] as String,
      howDaysHabitsDo: habitMap['how_days_habits_do'] as int,
      howMuchInDay: habitMap['how_much_in_day'] as int,
      minutsOrTimes: MinutsOrTimes.values[habitMap['minuts_or_times'] as int],
      remind: (habitMap['remind'] as int) == 1,
      timeRemind: habitMap['time_remind'] != null
          ? DateTime.fromMillisecondsSinceEpoch(habitMap['time_remind'] as int)
          : null,
      /////!!!!!!!!!
      week: Week.fromMap(weekMap),
      color: habitMap['color'] as int,
    );
  }
}
