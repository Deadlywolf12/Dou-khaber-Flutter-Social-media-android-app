import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String lastMessage;
  final String photo;
  final Timestamp time;
  final String uid;
  final String name;
  ChatModel(this.lastMessage, this.photo, this.time, this.uid, this.name);

  Map<String, dynamic> toMap() {
    return {
      "lastMessage": lastMessage,
      "photo": photo,
      "time": time,
      "uid": uid,
      "name": name,
    };
  }
}
