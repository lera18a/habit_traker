import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_traker/logic_layer/bloc/habit_bloc/habit_bloc.dart';

class BlocHabitLoadingOrNo extends StatelessWidget {
  const BlocHabitLoadingOrNo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitBloc, HabitState>(
      builder: (context, state) {
        if (state is HabitLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HabitLoadingFailedState) {
          return Center(child: Text('Ошибка: ${state.message}'));
        } else if (state is HabitLoadedSuccessState) {
          final habits = state.habits;
          if (habits.isEmpty) {
            return const Center(child: Text('Нет привычек'));
          }
          return ListView.builder(
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return Dismissible(
                key: ValueKey(habit.id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  context.read<HabitBloc>().add(HabitDeleteEvent(habit: habit));
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text(habit.name),
                  subtitle: Text('Дней: ${habit.howDaysHabitsDo.toString()}'),
                ),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
