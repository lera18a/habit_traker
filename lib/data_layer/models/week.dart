class Week {
  final bool? mon;
  final bool? tue;
  final bool? wed;
  final bool? thu;
  final bool? fri;
  final bool? sat;
  final bool? sun;
  Week({
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
  });

  //метод toMap
  //Этот метод нужен, чтобы подготовить данные к сохранению в БД SQLite.
  Map<String, dynamic> toMap({required int habitId}) {
    return {
      'habit_id': habitId,
      'mon': mon == true ? 1 : 0,
      'tue': tue == true ? 1 : 0,
      'wed': wed == true ? 1 : 0,
      'thu': thu == true ? 1 : 0,
      'fri': fri == true ? 1 : 0,
      'sat': sat == true ? 1 : 0,
      'sun': sun == true ? 1 : 0,
    };
  }

  factory Week.fromMap(Map<String, dynamic> map) {
    return Week(
      mon: map['mon'] == null ? null : (map['mon'] as int) == 1,
      tue: map['tue'] == null ? null : (map['tue'] as int) == 1,
      wed: map['wed'] == null ? null : (map['wed'] as int) == 1,
      thu: map['thu'] == null ? null : (map['thu'] as int) == 1,
      fri: map['fri'] == null ? null : (map['fri'] as int) == 1,
      sat: map['sat'] == null ? null : (map['sat'] as int) == 1,
      sun: map['sun'] == null ? null : (map['sun'] as int) == 1,
    );
  }
}
