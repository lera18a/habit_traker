import 'package:flutter/material.dart';
import 'package:habit_traker/widget/ui/common/grey_container.dart';

class HowTimeHabitDoButton extends StatelessWidget {
  const HowTimeHabitDoButton({
    super.key,
    required this.icon,
    required this.text,
    required this.hintText,
    required this.controller,
  });
  final Icon icon;
  final String text;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return GreyContainer(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(children: [icon, const SizedBox(width: 8), Text(text)]),
          SizedBox(
            width: 60,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
