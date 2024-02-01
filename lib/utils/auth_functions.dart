import 'dart:typed_data';
import 'package:cinepopapp/config/models/user_model.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../config/resources/app_strings.dart';
import '../config/resources/storage_method.dart';

class AuthFunctions {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signup(
      BuildContext context,
      String pass,
      String pass2,
      String fullName,
      String phone,
      String location,
      String dateOfBirth,
      String email,
      Uint8List file) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      //store user data to database

      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);

      model.User user = model.User(
          name: fullName,
          location: location,
          birth: dateOfBirth,
          phone: phone,
          email: email,
          uid: cred.user!.uid,
          followers: [],
          following: [],
          photoUrl: photoUrl);

      await _firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toJason());

      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      if (e.code == Appstrings.emailAlreadyInUseException) {
        return Appstrings.emailAlreadyInUsePrompt;
      } else if (e.code == Appstrings.invalidEmailException) {
        return Appstrings.invalidEmailPrompt;
      } else if (e.code == Appstrings.networkErrorException) {
        return Appstrings.networkErrorPrompt;
      } else {
        return e.code;
      }
    }

    return Appstrings.success;
  }

  Future<String> signin(
    String email,
    String pass,
  ) async {
    if (email.isNotEmpty && pass.isNotEmpty) {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
        // ignore: use_build_context_synchronously
      } on FirebaseAuthException catch (e) {
        if (e.code == Appstrings.userNotFoundException) {
          return Appstrings.wrongemailPrompt;
        } else if (e.code == Appstrings.wrongPasswordException) {
          return Appstrings.wrongpassPrompt;
        } else if (e.code == Appstrings.networkErrorException) {
          return Appstrings.networkErrorPrompt;
        } else if (e.code == Appstrings.disabledUserException) {
          return Appstrings.disabledUserPrompt;
        }
      }
    } else {
      return Appstrings.emptyFields2Prompt;
    }
    return Appstrings.success;
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<String> resetPass(String email) async {
    try {
      if (email.isEmpty) {
        return "Field Connot be empty";
      } else {
        await _auth.sendPasswordResetEmail(email: email);
        return "Email has been sent to the email address";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
