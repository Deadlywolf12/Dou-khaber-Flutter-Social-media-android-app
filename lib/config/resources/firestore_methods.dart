import 'dart:typed_data';
import 'package:cinepopapp/config/resources/app_strings.dart';
import 'package:cinepopapp/config/resources/storage_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';

import '../models/Posts.dart';
import 'package:intl/intl.dart';

class FirestoreMethods {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  //upload post

  Future<String> uploadPost(Uint8List photo, String uid, String description,
      String userName, String profilePic) async {
    String res = 'errors';
    String postUId = const Uuid().v1();

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("Posts", photo, true);
      DateTime date = DateTime.now();
      Posts post = Posts(
          datePublished: DateFormat.yMMMd().format(date),
          description: description,
          likes: [],
          name: userName,
          postId: postUId,
          postUrl: photoUrl,
          profilePic: profilePic,
          uid: uid);
      _store.collection('Posts').doc(postUId).set(
            post.toJason(),
          );

      res = Appstrings.success;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _store.collection('Posts').doc(postId).update(
          {
            'likes': FieldValue.arrayRemove(
              [uid],
            ),
          },
        );
      } else {
        await _store.collection('Posts').doc(postId).update(
          {
            'likes': FieldValue.arrayUnion(
              [uid],
            ),
          },
        );
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> postComment(String postId, String text, String name, String uid,
      String profilePic) async {
    String commentId = const Uuid().v1();
    try {
      if (text.isNotEmpty) {
        await _store
            .collection('Posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          "name": name,
          "postId": postId,
          "comment": text,
          "commentId": commentId,
          "uid": uid,
          "profilepic": profilePic,
          "datePublished": DateTime.now(),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<String> deletePost(String postId) async {
    String isDeleted;
    try {
      await _store.collection('Posts').doc(postId).delete();
      isDeleted = "Deleted Successfully";
    } catch (e) {
      isDeleted = "Could'nt delete with error - ${e.toString()}";
    }
    return isDeleted;
  }

  Future<void> followUsers(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followId)) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove(
            [followId],
          ),
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(followId)
            .update({
          'followers': FieldValue.arrayRemove(
            [uid],
          ),
        });
      } else {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion(
            [followId],
          ),
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(followId)
            .update({
          'followers': FieldValue.arrayUnion(
            [uid],
          ),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateFields(
      String value, String uid, String field, String oldVal) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update({field: value});
      if (oldVal.isNotEmpty) {
        CollectionReference posts = _store.collection("Posts");
        QuerySnapshot querySnapshot =
            await posts.where("username", isEqualTo: oldVal).get();

        querySnapshot.docs.forEach((doc) async {
          String docId = doc.id;

          // Update the username field with the new value
          await posts.doc(docId).update({
            'username': value,
          });

          print('Document $docId successfully updated!');
        });
      }
    } catch (e) {
      print('Error updating document: $e');
    }
  }
}
