import 'package:cinepopapp/components/app_snack_bar.dart';
import 'package:cinepopapp/components/app_tool_bar.dart';
import 'package:cinepopapp/components/custom_button.dart';
import 'package:cinepopapp/utils/auth_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    String content;
    return Scaffold(
      appBar: const Apptoolbar(title: "Reset Password"),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Reset Your Password",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            Text(
              "Please enter your Email and we will send you reset link",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "email@gmail.com",
                icon: Icon(Icons.person),
                labelText: "Email*",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              btnName: "Reset",
              onpressed: () async {
                content = await AuthFunctions()
                    .resetPass(_emailController.text.trim());
                AppSnackBar().showSnackBar(content, context);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
