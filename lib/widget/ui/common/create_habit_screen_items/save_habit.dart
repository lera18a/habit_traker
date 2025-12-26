import 'package:flutter/material.dart';

class SaveHabit extends StatelessWidget {
  const SaveHabit({super.key, required this.onPressed});

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text('Сохранить'));
  }
}
