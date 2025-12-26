import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_traker/data_layer/models/habit.dart';
import 'package:habit_traker/data_layer/models/week.dart';
import 'package:habit_traker/logic_layer/bloc/habit_bloc/habit_bloc.dart';
import 'package:habit_traker/widget/ui/common/create_habit_screen_items/how_time_habit_do_button.dart';
import 'package:habit_traker/widget/ui/common/create_habit_screen_items/remind_icon_button.dart';
import 'package:habit_traker/widget/ui/common/create_habit_screen_items/save_habit.dart';
import 'package:habit_traker/widget/ui/common/create_habit_screen_items/text_name_of_habit_button.dart';
import 'package:habit_traker/widget/ui/common/create_habit_screen_items/times_or_minuts_button.dart';
import 'package:habit_traker/widget/ui/common/create_habit_screen_items/week_reminder_container.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({super.key});

  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  late final TextEditingController nameHabitController;
  late final TextEditingController dayHabitController;
  late final TextEditingController timesHabitController;

  MinutsOrTimes minutsOrTimes = MinutsOrTimes.times;
  final List<bool> weekDays = List<bool>.filled(7, false);

  DateTime remindTime = DateTime.now();
  bool remindToggle = false;

  @override
  void initState() {
    nameHabitController = TextEditingController();
    dayHabitController = TextEditingController();
    timesHabitController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameHabitController.dispose();
    dayHabitController.dispose();
    timesHabitController.dispose();
    super.dispose();
  }

  void _toggleMinutsOrTimes() {
    setState(() {
      minutsOrTimes = (minutsOrTimes == MinutsOrTimes.times)
          ? MinutsOrTimes.minuts
          : MinutsOrTimes.times;
    });
  }

  void _weekDayChanged(int index, bool? value) {
    setState(() {
      // ?? — оператор «если слева не null, возьми её, иначе возьми справа».
      weekDays[index] = value ?? false;
    });
  }

  void _remindateTimeChanged(DateTime value) {
    setState(() {
      remindTime = value;
    });
  }

  void _remindSwitchChanged(bool value) {
    setState(() {
      remindToggle = value;
    });
  }

  void _saveHabit() {
    final week = Week(
      mon: weekDays[0],
      tue: weekDays[1],
      wed: weekDays[2],
      thu: weekDays[3],
      fri: weekDays[4],
      sat: weekDays[5],
      sun: weekDays[6],
    );

    final habit = Habit(
      id: null,
      name: nameHabitController.text,
      howDaysHabitsDo: int.tryParse(dayHabitController.text) ?? 0,
      howMuchInDay: int.tryParse(timesHabitController.text) ?? 0,
      minutsOrTimes: minutsOrTimes,
      remind: remindToggle,
      timeRemind: remindToggle ? remindTime : null,
      week: week,
      color: 0xFF000000,
    );
    context.read<HabitBloc>().add(HabitCreateEvent(habit: habit));
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    final timeText =
        '${remindTime.hour.toString().padLeft(2, '0')}:'
        '${remindTime.minute.toString().padLeft(2, '0')}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Подробности'),
        actions: [SaveHabit(onPressed: _saveHabit)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: .min,
          children: [
            TextNameOfHabitButton(controller: nameHabitController),
            SizedBox(height: 15),
            HowTimeHabitDoButton(
              icon: Icon(CupertinoIcons.star),
              text: 'Дней для привычки',
              hintText: '5',
              controller: dayHabitController,
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 58,
              child: Row(
                crossAxisAlignment: .center,
                children: [
                  Flexible(
                    flex: 2,
                    child: HowTimeHabitDoButton(
                      icon: Icon(CupertinoIcons.return_icon),
                      text: 'В день',
                      hintText: '1',
                      controller: timesHabitController,
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    flex: 1,
                    child: TimesOrMinutsButton(
                      onTap: _toggleMinutsOrTimes,
                      minutsOrTimes: minutsOrTimes,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            WeekReminderContainer(
              weekDays: const ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'],
              listBool: weekDays,
              onChanged: _weekDayChanged,
            ),
            SizedBox(height: 15),
            RemindIconButton(
              initialDateTime: remindTime,
              onDateTimeChanged: _remindateTimeChanged,
              timeText: remindToggle ? timeText : '',
              onChangedSwitch: _remindSwitchChanged,
              switchToggle: remindToggle,
            ),
          ],
        ),
      ),
    );
  }
}
