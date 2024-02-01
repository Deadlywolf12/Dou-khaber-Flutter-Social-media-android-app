import 'package:cinepopapp/components/app_snack_bar.dart';
import 'package:cinepopapp/components/chat_tiles.dart';
import 'package:cinepopapp/components/custom_button.dart';
import 'package:cinepopapp/pages/chat_room_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false;
  bool isShowBack = false;
  bool chatsExist = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    CollectionReference itemsCollection =
        FirebaseFirestore.instance.collection('chats');

    // Reference to the specific document
    DocumentReference documentReference =
        itemsCollection.doc(FirebaseAuth.instance.currentUser!.uid);

    try {
      // Get the document snapshot
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        setState(() {
          chatsExist = true;
          isLoading = false;
        });
      } else {
        setState(() {
          chatsExist = false;
          isLoading = false;
        });
      }
    } catch (e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: isShowBack
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isShowUsers = false;
                    isShowBack = false;

                    _searchController.text = "";
                  });
                },
                icon: const Icon(Icons.arrow_back))
            : const Text(""),
        title: Text(
          "Chats",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        actions: [
          IconButton(
              onPressed: () {
                getDialoge();
              },
              icon: const Icon(Icons.add_comment_rounded))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Appcolors.primary,
              ),
            )
          : isShowUsers
              ? FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .where('full name',
                          isGreaterThanOrEqualTo: _searchController.text)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if ((snapshot.data! as dynamic).docs.length == 0) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                                child: Text(
                              "No user Found !",
                              style: TextStyle(fontSize: 20),
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 35,
                              width: 150,
                              child: CustomButton(
                                  btnName: "Cancel",
                                  onpressed: () {
                                    setState(() {
                                      isShowUsers = false;
                                      isShowBack = false;
                                      _searchController.text = "";
                                    });
                                  }),
                            )
                          ]);
                    }
                    return ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChatRoom(
                                  reciverUid: (snapshot.data! as dynamic)
                                      .docs[index]['uid'],
                                ),
                              ),
                            );
                            setState(() {
                              isShowUsers = false;
                              isShowBack = false;
                              _searchController.text = "";
                            });
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            tileColor: Theme.of(context).colorScheme.background,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                (snapshot.data! as dynamic).docs[index]
                                    ['photo-url'],
                              ),
                            ),
                            title: Text(
                              (snapshot.data! as dynamic).docs[index]
                                  ['full name'],
                            ),
                            trailing:
                                const Icon(Icons.arrow_circle_right_sharp),
                            subtitle: Text(
                              "Start chatting with ${(snapshot.data! as dynamic).docs[index]['full name']} Now!",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        );
                      }),
                    );
                  },
                )
              : chatsExist
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('chats')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('activeChats')
                          .orderBy('time', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            itemBuilder: (context, index) => ChatTiles(
                              snap: (snapshot.data! as dynamic)
                                  .docs[index]
                                  .data(),
                            ),
                          );
                        } else {
                          return const Text("data could'nt be fetched");
                        }
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/sadFace.png",
                            width: 110,
                            height: 110,
                          ),
                          const Text(
                            "Opps, Looks like you have no active chats :(",
                            style: TextStyle(fontSize: 18),
                          ),
                          const Text("Start Chatting now !",
                              style: TextStyle(fontSize: 15)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  getDialoge();
                                },
                                icon: Icon(
                                  Icons.chat,
                                  size: 40,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.replay_outlined,
                                    size: 40,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 110, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            getDialoge();
          },
          child: Icon(
            Icons.chat,
            color: Appcolors.primary,
          ),
        ),
      ),
    );
  }

  Future<dynamic> getDialoge() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Search Users"),
        content: TextFormField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Enter username",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onFieldSubmitted: (String _) {
            if (_searchController.text.trim().isNotEmpty) {
              Navigator.of(context).pop();
              setState(() {
                isShowUsers = true;
                isShowBack = true;
              });
            } else {
              AppSnackBar().showSnackBar("Please write a username", context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                Navigator.of(context).pop();

                setState(() {
                  isShowUsers = true;
                  isShowBack = true;
                });
              } else {
                AppSnackBar().showSnackBar("Please write a username", context);
              }
            },
            child: const Text("Search"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
}
