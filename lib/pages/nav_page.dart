import 'package:cinepopapp/components/App_Nav_Buttons.dart';
import 'package:cinepopapp/config/resources/app_icons.dart';
import 'package:cinepopapp/pages/feed_page.dart';
import 'package:cinepopapp/pages/profile_page.dart';
import 'package:cinepopapp/config/providers/user_provider.dart';
import 'package:cinepopapp/pages/search_page.dart';

import 'package:cinepopapp/styles/app_colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../components/add_post_bottom_sheet.dart';
import 'chat_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  Menu currentIndexflag = Menu.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[currentIndexflag.index],
      bottomNavigationBar: AppNavigationBar(
          currentIndex: currentIndexflag,
          onTap: (value) {
            if (value == Menu.add) {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return const AddPostBottomSheet();
                  });
              return;
            }
            setState(() {
              currentIndexflag = value;
            });
          }),
    );
  }

  final pages = [
    const Feed(),
    const Search(),
    const Center(
      child: Text("this is a add"),
    ),
    const ChatPage(),
    Profilepage(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];
}

enum Menu {
  home,
  search,
  add,
  chat,
  profile,
}

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  final Menu currentIndex;
  final ValueChanged<Menu> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      margin: const EdgeInsets.all(24),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 17,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: AppNavButtons(
                          onPressed: () => onTap(Menu.home),
                          icon: Appicons.icHome,
                          current: currentIndex,
                          name: Menu.home)),
                  Expanded(
                      child: AppNavButtons(
                          onPressed: () => onTap(Menu.search),
                          icon: Appicons.icSearch,
                          current: currentIndex,
                          name: Menu.search)),
                  const Spacer(),
                  Expanded(
                      child: AppNavButtons(
                          onPressed: () => onTap(Menu.chat),
                          icon: Appicons.icChat,
                          current: currentIndex,
                          name: Menu.chat)),
                  Expanded(
                    child: AppNavButtons(
                        onPressed: () => onTap(Menu.profile),
                        icon: Appicons.icUser,
                        current: currentIndex,
                        name: Menu.profile),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () => onTap(Menu.add),
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Appcolors.primary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(Appicons.icAdd),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
