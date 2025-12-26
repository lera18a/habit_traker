import 'package:flutter/cupertino.dart';
import 'package:habit_traker/widget/ui/common/grey_container.dart';

class RemindIconButton extends StatefulWidget {
  const RemindIconButton({
    super.key,
    required this.initialDateTime,
    required this.onDateTimeChanged,
    required this.timeText,
    required this.onChangedSwitch,
    required this.switchToggle,
  });
  final DateTime initialDateTime;
  final void Function(DateTime) onDateTimeChanged;
  final String timeText;
  final bool switchToggle;
  final void Function(bool)? onChangedSwitch;

  @override
  State<RemindIconButton> createState() => _RemindIconButtonState();
}

class _RemindIconButtonState extends State<RemindIconButton> {
  bool _showPicker = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _showPicker = !_showPicker;
            });
          },
          child: GreyContainer(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Row(
              children: [
                Icon(CupertinoIcons.bell),
                SizedBox(width: 10),
                Text('Напомнить в'),
                Spacer(),
                Text(widget.timeText),
                SizedBox(width: 10),
                CupertinoSwitch(
                  value: widget.switchToggle,
                  onChanged: widget.onChangedSwitch,
                ),
              ],
            ),
          ),
        ),
        if (_showPicker)
          Container(
            height: 250,
            color: CupertinoColors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              initialDateTime: widget.initialDateTime,
              onDateTimeChanged: widget.onDateTimeChanged,
            ),
          ),
      ],
    );
  }
}
