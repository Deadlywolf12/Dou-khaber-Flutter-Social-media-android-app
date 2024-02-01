import 'package:flutter/material.dart';

class Apptoolbar extends StatelessWidget implements PreferredSize {
  final String title;
  final List<Widget>? actions;
  const Apptoolbar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
      centerTitle: false,
      actions: actions,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
