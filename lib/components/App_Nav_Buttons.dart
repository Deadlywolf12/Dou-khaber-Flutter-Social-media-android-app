import 'package:cinepopapp/pages/nav_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppNavButtons extends StatelessWidget {
  const AppNavButtons(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.current,
      required this.name});
  final VoidCallback onPressed;
  final String icon;
  final Menu current;
  final Menu name;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
            current == name
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.shadow,
            BlendMode.srcIn),
      ),
    );
  }
}
