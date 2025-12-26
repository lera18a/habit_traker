import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_traker/widget/ui/common/create_habit_screen_items.dart/checkbox_item.dart';

import 'package:habit_traker/widget/ui/common/grey_container.dart';

class WeekReminderContainer extends StatelessWidget {
  const WeekReminderContainer({
    super.key,
    required this.weekDays,
    required this.listBool,
    required this.onChanged,
  });
  final List<String> weekDays;
  final List<bool> listBool;

  final void Function(int index, bool? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return GreyContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(weekDays.length, (index) {
              return CheckboxItem(
                label: weekDays[index],
                onChanged: (val) => onChanged(index, val),
                isChecked: listBool[index],
              );
            }),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
