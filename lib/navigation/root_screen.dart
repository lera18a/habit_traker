import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_traker/navigation/app_router.dart';
import 'package:habit_traker/widget/bloc/bloc_habit_create.dart';

@RoutePage()
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [TodayRoute(), ProgressRoute(), SettingsRoute()],
      floatingActionButton: const BlocHabitCreate(),
      bottomNavigationBuilder: ((_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              label: 'Сегодня',
              icon: const Icon(CupertinoIcons.home),
            ),
            BottomNavigationBarItem(
              label: 'Прогресс',
              icon: Icon(CupertinoIcons.bolt_fill),
            ),
            BottomNavigationBarItem(
              label: 'Настройки',
              icon: Icon(CupertinoIcons.settings),
            ),
          ],
        );
      }),
    );
  }
}
