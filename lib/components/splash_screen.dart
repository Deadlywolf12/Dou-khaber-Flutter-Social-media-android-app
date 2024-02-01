import 'package:cinepopapp/styles/app_colors.dart';

import 'package:flutter/material.dart';

import '../config/resources/app_routes.dart';
import '../config/resources/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigator();
  }

  _navigator() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (mounted) {
      Navigator.pushReplacementNamed(context, Approutes.userAuth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Appcolors.background,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Image.asset("assets/images/props/splash.png"),
          ),
          const Text(
            Appstrings.appName,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Colors.yellow),
          ),
          const SizedBox(
            height: 15,
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          ),
        ]),
      ),
    );
  }
}
