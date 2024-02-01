import 'package:cinepopapp/styles/app_text.dart';
import 'package:flutter/material.dart';

import '../pages/profile_page.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Profilepage(
                    uid: widget.snap['uid'],
                  ),
                ),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.snap['profilepic'],
                ),
                radius: 16,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.snap['name'],
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      TextSpan(
                        text: " ${widget.snap['comment']}",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
