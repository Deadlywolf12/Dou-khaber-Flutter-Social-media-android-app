import 'package:cinepopapp/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TextBlock extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onpressed;

  const TextBlock(
      {super.key,
      required this.text,
      required this.sectionName,
      this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 121, 120, 120),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 127, 127, 127).withOpacity(0.3),
            spreadRadius: 0.2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //section name
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              sectionName,
              style: const TextStyle(fontSize: 20, color: Colors.white70),
            ),
            IconButton(
              onPressed: onpressed,
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ]),
          //Data
          Text(
            text,
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}
