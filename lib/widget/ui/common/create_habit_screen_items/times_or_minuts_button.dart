import 'package:flutter/material.dart';
import 'package:habit_traker/data_layer/models/habit.dart';
import 'package:habit_traker/widget/ui/common/grey_container.dart';

class TimesOrMinutsButton extends StatelessWidget {
  final MinutsOrTimes minutsOrTimes;
  final void Function() onTap;
  const TimesOrMinutsButton({
    super.key,
    required this.onTap,
    required this.minutsOrTimes,
  });

  @override
  Widget build(BuildContext context) {
    final text = minutsOrTimes == MinutsOrTimes.times ? 'раз' : 'минут';
    return GreyContainer(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 50),
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
