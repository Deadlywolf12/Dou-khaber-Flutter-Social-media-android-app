import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String description;
  final String uid;
  final String name;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profilePic;
  final likes;

  const Posts({
    required this.name,
    required this.description,
    required this.uid,
    required this.profilePic,
    required this.postId,
    required this.datePublished,
    required this.likes,
    required this.postUrl,
  });

  Map<String, dynamic> toJason() => {
        'username': name,
        'postId': postId,
        'postUrl': postUrl,
        'profilePic': profilePic,
        'description': description,
        'uid': uid,
        'datePublished': datePublished,
        'likes': likes,
      };

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Posts(
      name: snapshot['username'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      profilePic: snapshot['profilePic'],
      description: snapshot['description'],
      uid: snapshot['uid'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
    );
  }
}
