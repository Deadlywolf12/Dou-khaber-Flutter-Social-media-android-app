import 'package:cinepopapp/components/app_snack_bar.dart';
import 'package:cinepopapp/components/app_tool_bar.dart';

import 'package:cinepopapp/components/follow_button.dart';

import 'package:cinepopapp/config/resources/app_routes.dart';
import 'package:cinepopapp/config/resources/app_strings.dart';
import 'package:cinepopapp/config/resources/firestore_methods.dart';
import 'package:cinepopapp/pages/settings_page.dart';

import 'package:cinepopapp/styles/app_colors.dart';
import 'package:cinepopapp/styles/app_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../utils/auth_functions.dart';
import 'chat_room_page.dart';

enum Profilemenu {
  settings,
  logout,
}

class Profilepage extends StatefulWidget {
  final String uid;
  const Profilepage({super.key, required this.uid});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isfollowing = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('Posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLength = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isfollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      AppSnackBar().showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Appcolors.primary,
            ),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: Apptoolbar(
              title: Appstrings.profileTitle,
              actions: [
                PopupMenuButton<Profilemenu>(
                  onSelected: (value) {
                    switch (value) {
                      case Profilemenu.settings:
                        Navigator.of(context).pushNamed(Approutes.settings);
                        break;
                      case Profilemenu.logout:
                        AuthFunctions().signUserOut();
                      default:
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: Profilemenu.settings,
                        child: Text(Appstrings.settings),
                      ),
                      const PopupMenuItem(
                        value: Profilemenu.logout,
                        child: Text(Appstrings.logout),
                      ),
                    ];
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: ((context) => Dialog(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: double.infinity,
                                child: FadeInImage.assetNetwork(
                                  image: userData['photo-url'],
                                  placeholder:
                                      'assets/images/props/placeHolder.png',
                                  imageErrorBuilder: (context, error,
                                          stackTrace) =>
                                      const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            "Error occured while loading the image from server\n Please Check your internet connection !"),
                                      ]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      );
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(userData['photo-url']),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    userData['full name'],
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    userData['location'],
                    style: Apptext.subtitle3,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '$followers',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const Text(
                            Appstrings.followers,
                            style: Apptext.subtitle3,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '$postLength',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const Text(
                            Appstrings.posts,
                            style: Apptext.subtitle3,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '$following',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const Text(
                            Appstrings.following,
                            style: Apptext.subtitle3,
                          ),
                        ],
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FirebaseAuth.instance.currentUser!.uid == widget.uid
                          ? Row(
                              children: [
                                FollowBtn(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background,
                                  borderColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  textColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  text: "Edit",
                                  onpressed: () {
                                    Navigator.of(context)
                                        .pushNamed(Approutes.editpro);
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SettingsPage(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.settings))
                              ],
                            )
                          : isfollowing
                              ? Row(
                                  children: [
                                    FollowBtn(
                                      backgroundColor: Appcolors.white,
                                      borderColor: Appcolors.primary,
                                      textColor: Appcolors.background,
                                      text: "UnFollow",
                                      onpressed: () async {
                                        await FirestoreMethods().followUsers(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['uid']);
                                        setState(() {
                                          isfollowing = false;
                                          followers--;
                                        });
                                      },
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => ChatRoom(
                                                reciverUid: userData["uid"],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.chat))
                                  ],
                                )
                              : Row(
                                  children: [
                                    FollowBtn(
                                      backgroundColor: Appcolors.primary,
                                      borderColor: Appcolors.primary,
                                      textColor: Appcolors.background,
                                      text: "Follow",
                                      onpressed: () async {
                                        await FirestoreMethods().followUsers(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['uid']);

                                        setState(() {
                                          isfollowing = true;
                                          followers++;
                                        });
                                      },
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => ChatRoom(
                                                reciverUid: userData["uid"],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.chat))
                                  ],
                                ),
                    ],
                  ),
                  const Divider(),
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('Posts')
                          .where('uid', isEqualTo: widget.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GridView.builder(
                            shrinkWrap: true,
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 1.5,
                                    childAspectRatio: 1),
                            itemBuilder: ((context, index) {
                              DocumentSnapshot snap =
                                  (snapshot.data! as dynamic).docs[index];
                              //add for open post

                              return GestureDetector(
                                onTap: () {},
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      "assets/images/props/placeHolder.png",
                                  imageErrorBuilder: (context, error,
                                          stackTrace) =>
                                      const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            "Error occured while loading the image from server\n Please Check your internet connection !"),
                                      ]),
                                  image: snap['postUrl'],
                                ),
                              );
                            }));
                      }),
                ],
              ),
            ),
          );
  }
}
