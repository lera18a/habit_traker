import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_traker/navigation/app_router.dart';

class BlocHabitCreate extends StatelessWidget {
  const BlocHabitCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.router.push(CreateHabitRoute());
      },
      child: const Icon(Icons.add),
    );
  }
}
