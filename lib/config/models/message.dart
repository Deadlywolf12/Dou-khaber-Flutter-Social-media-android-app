import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String reciverUid;
  final String reciverEmail;
  final String senderUid;
  final String senderEmail;
  final String message;
  final Timestamp time;
  MessageModel(this.reciverUid, this.reciverEmail, this.senderUid,
      this.senderEmail, this.time, this.message);
  Map<String, dynamic> toMap() {
    return {
      'reciverUid': reciverUid,
      'reciverEmail': reciverEmail,
      'senderUid': senderUid,
      'senderEmail': senderEmail,
      'time': time,
      'message': message,
    };
  }
}
