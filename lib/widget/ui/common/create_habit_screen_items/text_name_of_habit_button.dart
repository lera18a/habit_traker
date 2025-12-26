import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_traker/widget/ui/common/grey_container.dart';

class TextNameOfHabitButton extends StatelessWidget {
  final TextEditingController controller;
  const TextNameOfHabitButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GreyContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Row(
        children: [
          Icon(CupertinoIcons.create),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Читать книгу, Медитировать',
                border: InputBorder.none,
              ),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
