// ignore_for_file: must_be_immutable

import 'package:cinepopapp/components/app_tool_bar.dart';
import 'package:cinepopapp/components/textblock.dart';

import 'package:cinepopapp/config/resources/app_strings.dart';
import 'package:cinepopapp/config/resources/firestore_methods.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/app_snack_bar.dart';
import '../config/providers/user_provider.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const Apptoolbar(title: Appstrings.editProfileTitle),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(14),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage:
                                  NetworkImage(userData["photo-url"]),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: () {},
                            iconSize: 30,
                            color: Colors.white,
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      userData["email"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "-Personal Details-",
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    TextBlock(
                      text: userData["full name"],
                      sectionName: 'Name',
                      onpressed: () => updateField(
                          "full name", "Name", userData["full name"]),
                    ),
                    TextBlock(
                        text: userData["location"],
                        sectionName: 'Location',
                        onpressed: () =>
                            updateField("location", "Location", "")),
                    TextBlock(
                        text: userData["phone"],
                        sectionName: 'Phone',
                        onpressed: () =>
                            updateField("phone", "Phone Number", "")),
                    TextBlock(
                        text: userData["birthday"],
                        sectionName: 'Date of birth',
                        onpressed: () =>
                            updateField("birthday", "Birthday", "")),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error${snapshot.error}"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<void> updateField(
      String fieldName, String title, String oldUsername) async {
    String newVal = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit " + title),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter New " + title,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newVal = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (newVal.isNotEmpty && mounted) {
                Navigator.of(context).pop();
                FirestoreMethods().updateFields(
                    newVal, currentUser.uid, fieldName, oldUsername);
                addData();
                AppSnackBar().showSnackBar(
                    "Successfully Updated $title , it may take some time to update",
                    context);
              }
            },
            child: const Text("Save"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }
}
