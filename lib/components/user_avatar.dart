import 'package:flutter/material.dart';

class Appavatar extends StatelessWidget {
  const Appavatar({super.key, this.size = 40});
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Image.asset(
        'assets/images/temp/user1.jpg',
        width: size,
        height: size,
      ),
    );
  }
}
