import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String location;
  final String birth;
  final String phone;
  final String email;
  final String uid;
  final List followers;
  final List following;
  final String photoUrl;

  const User(
      {required this.name,
      required this.location,
      required this.birth,
      required this.phone,
      required this.email,
      required this.uid,
      required this.followers,
      required this.following,
      required this.photoUrl});

  Map<String, dynamic> toJason() => {
        'full name': name,
        'location': location,
        'birthday': birth,
        'phone': phone,
        'email': email,
        'uid': uid,
        'followers': [],
        'following': [],
        'photo-url': photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot['full name'],
        location: snapshot['location'],
        birth: snapshot['birthday'],
        phone: snapshot['phone'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        photoUrl: snapshot['photo-url']);
  }
}
