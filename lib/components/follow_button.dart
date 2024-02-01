import 'package:flutter/material.dart';

class FollowBtn extends StatelessWidget {
  final Function()? onpressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String text;

  const FollowBtn(
      {super.key,
      this.onpressed,
      required this.backgroundColor,
      required this.borderColor,
      required this.textColor,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: onpressed,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: 220,
          height: 27,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
