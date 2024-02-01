import 'package:cinepopapp/components/app_snack_bar.dart';
import 'package:cinepopapp/components/like_annimation.dart';
import 'package:cinepopapp/config/models/user_model.dart' as model;

import 'package:cinepopapp/config/providers/user_provider.dart';
import 'package:cinepopapp/config/resources/firestore_methods.dart';
import 'package:cinepopapp/pages/comments_page.dart';

import 'package:cinepopapp/styles/app_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/profile_page.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLength = 0;
  bool isUserPost = false;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  Future<void> getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Posts")
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();

      commentLength = snap.docs.length;
      if (widget.snap['uid'] == FirebaseAuth.instance.currentUser!.uid) {
        isUserPost = true;
      } else {
        isUserPost = false;
      }
    } catch (e) {
      AppSnackBar().showSnackBar(e.toString(), context);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
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
                    radius: 18,
                    backgroundImage: NetworkImage(
                      widget.snap["profilePic"],
                    ),
                    backgroundColor: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Profilepage(
                                  uid: widget.snap['uid'],
                                ),
                              ),
                            ),
                            child: Text(
                              widget.snap["username"],
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isUserPost
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: ((context) => Dialog(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    shrinkWrap: true,
                                    children: ['Delete', 'Edit', 'Report']
                                        .map(
                                          (e) => InkWell(
                                            onTap: () async {
                                              if (e.toString() == 'Delete') {
                                                Navigator.of(context).pop();

                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          "Are You Sure ?",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        content: const Text(
                                                            "Once deleted cannot be undone!"),
                                                        actions: [
                                                          MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              AppSnackBar().showSnackBar(
                                                                  await FirestoreMethods()
                                                                      .deletePost(
                                                                          widget
                                                                              .snap['postId']),
                                                                  context);
                                                              if (mounted) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }
                                                            },
                                                            child: const Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          MaterialButton(
                                                            onPressed: () {
                                                              if (mounted) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }
                                                            },
                                                            child: const Text(
                                                                "Cancel"),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              }
                                              if (e.toString() == 'Edit') {
                                                print('edit clicked');
                                              }
                                              if (e.toString() == 'Report') {
                                                print('report clicked');
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )),
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    : IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: ((context) => Dialog(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    shrinkWrap: true,
                                    children: ['Report']
                                        .map(
                                          (e) => InkWell(
                                            onTap: () async {
                                              if (e.toString() == 'Report') {
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )),
                          );
                        },
                        icon: const Icon(Icons.more_vert_outlined),
                      ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                  widget.snap["postId"], user.uid, widget.snap['likes']);

              setState(() {
                isLikeAnimating = true;
              });
            },

            //user post
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: FadeInImage.assetNetwork(
                  image: widget.snap['postUrl'],
                  placeholder: 'assets/images/props/placeHolder.png',
                  imageErrorBuilder: (context, error, stackTrace) =>
                      const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Icon(
                          Icons.cloud_off,
                          color: Colors.red,
                          size: 50,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Error occured while loading the image from server\n Please Check your internet connection !",
                          style: TextStyle(fontSize: 15),
                        ),
                      ]),
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 120,
                  ),
                ),
              )
            ]),
          ),

          //like comment share
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                isSmallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                        widget.snap["postId"], user.uid, widget.snap['likes']);
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          size: 30,
                        ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showCommentScreen();
                },
                icon: const Icon(Icons.comment_outlined),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
                iconSize: 30,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      widget.snap['datePublished'],
                      style: Apptext.subtitle3,
                    ),
                  ),
                ),
              ),
            ],
          ),

          //description and num of comments
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '${widget.snap['likes'].length} likes',
                    style: Apptext.subtitle3,
                  ))
            ]),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: RichText(
                text: TextSpan(style: Apptext.subtitle3, children: [
              TextSpan(
                text: widget.snap['username'],
                style: Theme.of(context).textTheme.labelSmall,
              ),
              TextSpan(
                text: ' ${widget.snap['description']}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ])),
          ),
          InkWell(
            onTap: () {
              showCommentScreen();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "View all $commentLength comments,",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCommentScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Comments(
          snap: widget.snap,
        ),
      ),
    );
  }
}
