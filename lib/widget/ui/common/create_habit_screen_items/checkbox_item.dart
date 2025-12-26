import 'package:flutter/material.dart';

class CheckboxItem extends StatelessWidget {
  final String label;
  final void Function(bool?)? onChanged;
  final bool isChecked;

  const CheckboxItem({
    super.key,
    required this.label,
    required this.onChanged,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        Checkbox(
          splashRadius: 10,
          semanticLabel: label,
          activeColor: Colors.green[400],
          value: isChecked,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
