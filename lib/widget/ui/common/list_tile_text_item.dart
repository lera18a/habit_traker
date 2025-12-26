import 'package:flutter/material.dart';

class ListTileTextItem extends StatelessWidget {
  const ListTileTextItem({super.key, required this.title, required this.icon});
  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(title), trailing: icon);
  }
}
