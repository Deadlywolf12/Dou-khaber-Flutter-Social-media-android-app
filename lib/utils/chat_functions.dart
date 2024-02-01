import 'package:cinepopapp/config/models/chats_model.dart';
import 'package:cinepopapp/config/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatServices extends ChangeNotifier {
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SEND MESSAGE
  Future<void> sendMessage(
      String reciverId,
      String message,
      String reciverEmail,
      String photo,
      String senderPhoto,
      String name,
      String sendername) async {
    try {
      //get currentuser info
      final currentUserUid = _fireAuth.currentUser!.uid;
      final currentUserEmail = _fireAuth.currentUser!.email.toString();
      final Timestamp timestamp = Timestamp.now();
      //create new message
      MessageModel newMessage = MessageModel(reciverId, reciverEmail,
          currentUserUid, currentUserEmail, timestamp, message);
      //create unique room id
      List<String> ids = [currentUserUid, reciverId];
      ids.sort();
      String chatRoomIds = ids.join("_");

      ChatModel addChatDetailsForReciver = ChatModel(
          message, senderPhoto, timestamp, currentUserUid, sendername);
      ChatModel addChatDetailsForSender =
          ChatModel(message, photo, timestamp, reciverId, name);

      //Adding chat detials

      await _firestore
          .collection("chats")
          .doc(currentUserUid)
          .collection("activeChats")
          .doc(reciverId)
          .set(addChatDetailsForSender.toMap());

      await _firestore
          .collection("chats")
          .doc(currentUserUid)
          .set({"exits?": "yes"});

      await _firestore
          .collection("chats")
          .doc(reciverId)
          .collection("activeChats")
          .doc(currentUserUid)
          .set(addChatDetailsForReciver.toMap());

      await _firestore
          .collection("chats")
          .doc(reciverId)
          .set({"exits?": "yes"});

      //add message to database
      await _firestore.collection("chat_rooms").doc(chatRoomIds).set({
        "chatReciver": reciverEmail,
        "chatReciverUid": reciverId,
        "chatSenderEmail": currentUserEmail,
        "chatSenderUid": currentUserUid
      });

      await _firestore
          .collection("chat_rooms")
          .doc(chatRoomIds)
          .collection("messages")
          .add(newMessage.toMap());
    } catch (e) {
      e.toString();
    }
  }

  //GET MESSAGE
  Stream<QuerySnapshot> getMessages(String userUid, String otherUserUid) {
    List<String> ids = [userUid, otherUserUid];
    ids.sort();
    String chatRoomIds = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomIds)
        .collection("messages")
        .orderBy("time", descending: false)
        .snapshots();
  }

  Future<bool> checkIfDocumentExists(String documentId) async {
    // Reference to your Firestore collection
    CollectionReference itemsCollection =
        FirebaseFirestore.instance.collection('chats');

    // Reference to the specific document
    DocumentReference documentReference = itemsCollection.doc(documentId);

    try {
      // Get the document snapshot
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
