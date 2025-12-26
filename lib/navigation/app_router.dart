import 'package:auto_route/auto_route.dart';
import 'package:habit_traker/navigation/root_screen.dart';
import 'package:habit_traker/widget/ui/page/create_habit_screen.dart';
import 'package:habit_traker/widget/ui/page/progress_screen.dart';
import 'package:habit_traker/widget/ui/page/settings_screen.dart';
import 'package:habit_traker/widget/ui/page/today_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RootRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(page: TodayRoute.page, initial: true),
        AutoRoute(page: ProgressRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
    AutoRoute(page: CreateHabitRoute.page, path: '/create-habit'),
  ];
}
