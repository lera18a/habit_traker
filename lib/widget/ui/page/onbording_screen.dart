import 'package:flutter/material.dart';
import 'package:habit_traker/widget/ui/common/next_elevated_button.dart';

class OnbordingScreen extends StatelessWidget {
  const OnbordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/atomic_habits'),
        Positioned(bottom: 40, child: NextElevatedButton(text: 'Вперед!')),
      ],
    );
  }
}
