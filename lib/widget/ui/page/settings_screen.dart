import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_traker/widget/ui/common/list_tile_text_item.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTileTextItem(title: 'Тема', icon: Icon(Icons.sunny)),
        ListTileTextItem(title: 'Особые возможности', icon: Icon(Icons.add)),
        ListTileTextItem(title: 'Язык', icon: Icon(Icons.language)),
      ],
    );
  }
}
