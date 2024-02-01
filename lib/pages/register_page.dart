import 'package:cinepopapp/components/app_textfield.dart';
import 'package:cinepopapp/components/custom_button.dart';

import 'package:cinepopapp/config/resources/app_strings.dart';

import 'package:cinepopapp/pages/set_new_user_page.dart';

import 'package:flutter/material.dart';

import '../styles/app_text.dart';
import '../utils/check_fields_functions.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  RegisterPage({super.key, required this.showLoginPage});

  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObsureText = true;
  bool _isFieldNotFilled = false;
  bool _isFieldNotFilled1 = false;
  bool _isFieldNotFilled2 = false;
  String _passError = " ";
  String _confPassError = " ";

  final _getControllers = RegisterPage(showLoginPage: () {});

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
                    Appstrings.appName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    Appstrings.registerPageTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  Apptextfield(
                    readOnly: false,
                    icon: const Icon(Icons.email),
                    textInput: TextInputType.emailAddress,
                    tfhints: Appstrings.emailHint,
                    errorText:
                        _isFieldNotFilled ? Appstrings.invalidEmailError : null,
                    controller: _getControllers.registerEmailController,
                    hide: false,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Apptextfield(
                    readOnly: false,
                    icon: const Icon(Icons.lock),
                    sufIcon: IconButton(
                      onPressed: () {
                        _toggleShowPass();
                      },
                      icon: Icon(_isObsureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    tfhints: Appstrings.passwordhint,
                    errorText: _isFieldNotFilled1 ? _passError : null,
                    controller: _getControllers.registerPasswordController,
                    hide: _isObsureText,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Apptextfield(
                    readOnly: false,
                    icon: const Icon(Icons.lock),
                    errorText: _isFieldNotFilled2 ? _confPassError : null,
                    tfhints: Appstrings.confirmPassHint,
                    controller:
                        _getControllers.registerConfirmPasswordController,
                    hide: _isObsureText,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: CustomButton(
                      btnName: Appstrings.signup,
                      onpressed: () {
                        setState(() {
                          createAccount();
                        });
                      },
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        Appstrings.oldMember,
                        style: Apptext.body2,
                      ),
                      TextButton(
                        onPressed: () {
                          widget.showLoginPage();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: const Text(
                          Appstrings.signIn,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15),
                        ),
                      ),
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

  bool checkPass(String val1) {
    bool result = false;
    if (val1.isNotEmpty) {
      if (val1.length >= 8) {
      } else {
        _passError = Appstrings.shortPassPrompt;
        result = true;
      }
    } else {
      _passError = Appstrings.emptyFieldError;
      result = true;
    }
    return result;
  }

  bool enableButton() {
    checkFields();
    bool flag = false;
    if (!_isFieldNotFilled && !_isFieldNotFilled1 && !_isFieldNotFilled2) {
      flag = true;
    }
    return flag;
  }

  bool confirmPass(String val1, String val2) {
    bool result = false;
    if (val2.isNotEmpty) {
      if (val1 == val2) {
      } else {
        _confPassError = Appstrings.passNotMatchPrompt;
        result = true;
      }
    } else {
      _confPassError = Appstrings.confPassError;
      result = true;
    }
    return result;
  }

  void checkFields() {
    final t = CheckFields();

    _isFieldNotFilled =
        t.validateEmail(_getControllers.registerEmailController.text);
    _isFieldNotFilled1 =
        checkPass(_getControllers.registerPasswordController.text);

    _isFieldNotFilled2 = confirmPass(
        _getControllers.registerPasswordController.text,
        _getControllers.registerConfirmPasswordController.text);
  }

  void createAccount() {
    if (enableButton()) {
      final route = MaterialPageRoute(
        builder: (context) => UserDetails(
          getEmail: _getControllers.registerEmailController.text,
          getPassword: _getControllers.registerPasswordController.text,
          getPassword2: _getControllers.registerConfirmPasswordController.text,
        ),
      );
      Navigator.of(context).push(route);
    }
  }

  void _toggleShowPass() {
    setState(() {
      _isObsureText = !_isObsureText;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
