import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_traker/widget/bloc/bloc_habit_loading_or_no.dart';

@RoutePage()
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocHabitLoadingOrNo();
  }
}
