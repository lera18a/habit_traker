import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_traker/logic_layer/bloc/accessability_bloc.dart/accessability_bloc.dart';
import 'package:habit_traker/logic_layer/bloc/change_language_bloc/change_language_bloc.dart';
import 'package:habit_traker/logic_layer/bloc/change_theme_bloc/change_theme_bloc.dart';
import 'package:habit_traker/logic_layer/bloc/habit_bloc/habit_bloc.dart';

class BlocInjectorWidget extends StatelessWidget {
  const BlocInjectorWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangeThemeBloc()),
        BlocProvider(create: (context) => ChangeLanguageBloc()),
        BlocProvider(create: (context) => AccessabilityBloc()),
        BlocProvider(
          create: (context) => HabitBloc(habitService: context.read()),
        ),
      ],
      child: child,
    );
  }
}
