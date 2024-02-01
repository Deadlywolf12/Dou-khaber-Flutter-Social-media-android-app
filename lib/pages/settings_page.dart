import 'package:cinepopapp/components/app_tool_bar.dart';
import 'package:cinepopapp/components/custom_button.dart';
import 'package:cinepopapp/config/resources/app_icons.dart';
import 'package:cinepopapp/config/resources/app_routes.dart';
import 'package:cinepopapp/config/providers/user_provider.dart';
import 'package:cinepopapp/styles/app_colors.dart';
import 'package:cinepopapp/utils/auth_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/models/user_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: Apptoolbar(
        title: "Settings",
        actions: [
          IconButton(
            onPressed: () {
              AuthFunctions().signUserOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(user.photoUrl),
          ),
          Text(
            user.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            user.email,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: double.infinity,
                  child: CustomButton(
                    btnName: "Personal Info",
                    onpressed: () {
                      Navigator.of(context).pushNamed(Approutes.editpro);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                                shape: MaterialStatePropertyAll<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(21),
                                      topRight: Radius.circular(21),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Password and Security",
                                style: TextStyle(fontSize: 20),
                              ))),
                      SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Privacy",
                                style: TextStyle(fontSize: 20),
                              ))),
                      SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Display and Themes",
                                style: TextStyle(fontSize: 20),
                              ))),
                      SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(Approutes.help);
                              },
                              child: const Text(
                                "Help",
                                style: TextStyle(fontSize: 20),
                              ))),
                      SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                                shape: MaterialStatePropertyAll<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(21),
                                      bottomRight: Radius.circular(21),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(Approutes.about);
                              },
                              child: const Text(
                                "About",
                                style: TextStyle(fontSize: 20),
                              ))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: double.infinity,
                    child: CustomButton(
                        btnName: "Logout",
                        onpressed: () {
                          AuthFunctions().signUserOut();
                        })),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Follow us here",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        Appicons.icGoogle,
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        Appicons.icInsta,
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        Appicons.icweb,
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
