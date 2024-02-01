import 'package:cinepopapp/styles/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onpressed;

  const CustomButton(
      {super.key, required this.btnName, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll<Color>(
            Theme.of(context).colorScheme.onPrimaryContainer),
        backgroundColor: MaterialStatePropertyAll<Color>(
            Theme.of(context).colorScheme.primaryContainer),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
        ),
      ),
      child: Text(
        btnName,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
