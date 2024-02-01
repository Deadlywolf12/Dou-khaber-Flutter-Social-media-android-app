import 'dart:async';

import 'package:cinepopapp/components/post_card.dart';

import 'package:cinepopapp/pages/chat_page.dart';
import 'package:cinepopapp/pages/profile_page.dart';
import 'package:cinepopapp/styles/app_colors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../components/app_tool_bar.dart';

import '../config/resources/app_strings.dart';
import 'error_page.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

int errorFlag = 0;

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Apptoolbar(
        title: Appstrings.appName,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Profilepage(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                      )));
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            if (errorFlag == 0) {
              errorFlag++;
              return const ErrorPage(
                load: "loading please wait",
              );
            } else {
              return const ErrorPage(
                load: "",
              );
            }
          };
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return LiquidPullToRefresh(
              onRefresh: _refresh,
              color: Appcolors.primary,
              height: 200,
              animSpeedFactor: 2,
              showChildOpacityTransition: false,
              backgroundColor: Appcolors.background,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _refresh() async {
    return await Future.delayed(
      const Duration(seconds: 2),
    );
  }
}
