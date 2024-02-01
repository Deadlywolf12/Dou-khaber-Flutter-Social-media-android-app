import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ReciveChatBubble extends StatelessWidget {
  final String message;
  final Timestamp time;
  String formatedTime = "";

  ReciveChatBubble({
    super.key,
    required this.message,
    required this.time,
  }) {
    DateTime dateTime = time.toDate();
    formatedTime = DateFormat.jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
          color: Colors.blueGrey[200]),
      child: Column(
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
          Text(
            "At $formatedTime",
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
