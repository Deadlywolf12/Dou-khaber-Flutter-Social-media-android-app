import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final String data;
  const AppAlertDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error, size: 70),
      iconColor: Colors.red,
      title: Text(data),
    );
  }
}
