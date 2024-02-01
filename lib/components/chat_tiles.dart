import 'package:cinepopapp/components/app_snack_bar.dart';
import 'package:cinepopapp/styles/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/chat_room_page.dart';
import '../styles/app_text.dart';

class ChatTiles extends StatefulWidget {
  final snap;

  ChatTiles({super.key, required this.snap}) {}

  @override
  State<ChatTiles> createState() => _ChatTilesState();
}

class _ChatTilesState extends State<ChatTiles> {
  String formatedTime = "";

  @override
  void initState() {
    Timestamp time = widget.snap["time"];
    DateTime dateTime = time.toDate();
    formatedTime = DateFormat.jm().format(dateTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatRoom(reciverUid: widget.snap["uid"])));
      },
      child: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.snap["photo"]),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.snap['name'],
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      TextSpan(
                          text: " ${widget.snap['lastMessage']}",
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              " ${formatedTime}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
