import 'package:cinepopapp/components/app_tool_bar.dart';
import 'package:cinepopapp/components/comment_card.dart';
import 'package:cinepopapp/config/resources/firestore_methods.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/models/user_model.dart';
import '../config/providers/user_provider.dart';

class Comments extends StatefulWidget {
  final snap;
  const Comments({Key? key, required this.snap}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const Apptoolbar(title: "Comments"),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Posts')
              .doc(widget.snap["postId"])
              .collection('comments')
              .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context, index) => CommentCard(
                  snap: (snapshot.data! as dynamic).docs[index].data(),
                ),
              );
            }
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.photoUrl,
                ),
                radius: 16,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, left: 16),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                        hintText: 'Comment as ${user.name}',
                        border: InputBorder.none),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  FirestoreMethods().postComment(
                      widget.snap["postId"],
                      _commentController.text.trim(),
                      user.name,
                      user.uid,
                      user.photoUrl);
                  setState(() {
                    _commentController.text = "";
                  });
                },
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
                    'Post',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
