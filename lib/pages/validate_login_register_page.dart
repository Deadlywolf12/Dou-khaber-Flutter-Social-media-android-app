import 'package:cinepopapp/pages/login_page.dart';
import 'package:cinepopapp/pages/register_page.dart';
import 'package:flutter/material.dart';

class ValidateLoginRegister extends StatefulWidget {
  const ValidateLoginRegister({super.key});

  @override
  State<ValidateLoginRegister> createState() => _ValidateLoginRegisterState();
}

class _ValidateLoginRegisterState extends State<ValidateLoginRegister> {
  //initially show login page
  bool showLoginPage = true;
  void toggleScrn() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScrn);
    } else {
      return RegisterPage(showLoginPage: toggleScrn);
    }
  }
}
