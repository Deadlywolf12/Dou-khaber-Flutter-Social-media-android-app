import 'package:cinepopapp/components/app_textfield.dart';
import 'package:cinepopapp/components/custom_button.dart';
import 'package:cinepopapp/config/resources/app_icons.dart';

import 'package:cinepopapp/config/resources/app_strings.dart';
import 'package:cinepopapp/styles/app_text.dart';

import 'package:cinepopapp/utils/check_fields_functions.dart';

import 'package:cinepopapp/utils/auth_functions.dart';

import 'package:flutter/material.dart';

import '../components/app_snack_bar.dart';
import 'forgot_pass_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final t = CheckFields();
  bool _isLoading = false;

  bool _isObsureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    Appstrings.welcomeBackTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    Appstrings.continuetolog,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  Apptextfield(
                    readOnly: false,
                    icon: const Icon(
                      Icons.person,
                    ),
                    tfhints: Appstrings.emailHint,
                    controller: _emailController,
                    hide: false,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Apptextfield(
                    readOnly: false,
                    icon: const Icon(
                      Icons.key_outlined,
                    ),
                    sufIcon: IconButton(
                      onPressed: () {
                        _toggleShowPass();
                      },
                      icon: Icon(_isObsureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    tfhints: Appstrings.passwordhint,
                    controller: _passwordcontroller,
                    hide: _isObsureText,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ForgotPass(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary),
                        child: const Text(
                          Appstrings.forgotpass,
                          style: Apptext.subtitle3,
                        )),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 300,
                    height: 35,
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            btnName: Appstrings.login,
                            onpressed: () {
                              signIn();
                            },
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    Appstrings.loginwith,
                    style: Apptext.body2,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //todo signin with fb button
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Appicons.icFb,
                            width: 22,
                            height: 22,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            Appstrings.fblogin,
                            style: Apptext.subtitle3,
                          ),
                        ],
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Appicons.icGoogle,
                            width: 22,
                            height: 22,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            Appstrings.google,
                            style: Apptext.subtitle3,
                          ),
                        ],
                      )),
                  Row(
                    children: [
                      const Text(
                        Appstrings.newtoapp,
                        style: Apptext.body2,
                      ),
                      TextButton(
                          onPressed: () {
                            widget.showRegisterPage();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          child: const Text(
                            Appstrings.signup,
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    String res = "";

    setState(() {
      _isLoading = true;
    });

    res = await AuthFunctions()
        .signin(_emailController.text.trim(), _passwordcontroller.text.trim());

    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      if (res != Appstrings.success) {
        AppSnackBar().showSnackBar(res, context);
      }
    }
  }

  void _toggleShowPass() {
    setState(() {
      _isObsureText = !_isObsureText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }
}
