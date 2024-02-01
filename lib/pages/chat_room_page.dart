import 'package:cinepopapp/components/app_textfield.dart';
import 'package:cinepopapp/components/recive_chat_buble.dart';

import 'package:cinepopapp/components/send_chat_bubble.dart';

import 'package:cinepopapp/utils/chat_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/app_snack_bar.dart';
import '../styles/app_colors.dart';

class ChatRoom extends StatefulWidget {
  final String reciverUid;
  const ChatRoom({super.key, required this.reciverUid});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageController = TextEditingController();
  final ChatServices _cServices = ChatServices();
  final FirebaseAuth _firestore = FirebaseAuth.instance;
  var userData = {};
  var senderPhoto = {};
  bool isLoading = false;

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _cServices.sendMessage(
          userData["uid"],
          _messageController.text.trim(),
          userData["email"],
          userData["photo-url"],
          senderPhoto["photo-url"],
          userData["full name"],
          senderPhoto['full name']);
      _messageController.clear();
    } else {
      AppSnackBar().showSnackBar("Type something first", context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var getSenderPhoto = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      senderPhoto = getSenderPhoto.data()!;

      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.reciverUid)
          .get();
      userData = userSnap.data()!;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      AppSnackBar().showSnackBar(e.toString(), context);
    }
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
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userData["photo-url"]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      userData["full name"],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert_rounded,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                //Messages
                Expanded(
                  child: _buildMessageList(),
                ),
                //inpup to send message
                _buildInput(),
              ],
            ),
          );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream:
          _cServices.getMessages(userData["uid"], _firestore.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AppSnackBar()
              .showSnackBar("Error occured ${snapshot.error}", context);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Appcolors.primary,
            ),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _messageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _messageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //align according to sender or reciver
    var aligment = (data['senderUid'] == _firestore.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    bool isSender = (data['senderUid'] == _firestore.currentUser!.uid);
    return Container(
      alignment: aligment,
      child: Column(
        children: [
          SizedBox(height: 10),
          isSender
              ? SendChatBubble(
                  message: data['message'],
                  time: data['time'],
                )
              : ReciveChatBubble(
                  message: data['message'],
                  time: data['time'],
                ),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 60,
              child: Apptextfield(
                icon: const Icon(Icons.message),
                tfhints: "Type your message here!",
                hide: false,
                readOnly: false,
                controller: _messageController,
              ),
            ),
          ),
          //send button
          IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: const Icon(
              Icons.send,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
