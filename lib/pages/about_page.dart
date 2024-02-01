import 'package:cinepopapp/components/app_snack_bar.dart';
import 'package:cinepopapp/utils/url_links.dart';
import 'package:flutter/material.dart';

import '../components/app_tool_bar.dart';
import '../config/resources/app_icons.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const Apptoolbar(title: "About"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Read about Dou-Khaber \n",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "What is this app about? \n"
                        "\n",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text:
                        "Dou khaber is a urdu word dou means give and khaber means news , as this app involves updates from people around the world , \n"
                        "\nI decided to give it the name dou khaber , it's not a fully social app but can be called a semi social app because it does'nt have an option to make your posts private hence whole world is able to watch your post"
                        "\n",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: "\nAbout Developer\n"
                        "\n",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text:
                        "Created by Myself, Rushan khan , A computer science student of NUML university Hyderabad in September 2023 , Special thanks to ravan ranawat and mahdi mirzadeh for providing Flutter tutorials for free \n"
                        "\nThis app is just a start to my exploration to App development , soon i'll be creating many more apps so make sure to follow me on my Github and Linkedin\n"
                        "\nif you want , contact me at rushanjk@gmail.com\n"
                        "\n",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
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
              "Follow me here",
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
                  onTap: () async {
                    bool check = await UrlLinks()
                        .launchLink("https://github.com/Deadlywolf12");
                    if (!check && mounted) {
                      AppSnackBar()
                          .showSnackBar("Could not load the Url", context);
                    }
                  },
                  child: Image.asset(
                    Appicons.icgit,
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.06,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    bool check = await UrlLinks().launchLink(
                        "https://www.linkedin.com/in/rushan-khan-b62070170");
                    if (!check && mounted) {
                      AppSnackBar()
                          .showSnackBar("Could not load the Url", context);
                    }
                  },
                  child: Image.asset(
                    Appicons.iclink,
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.06,
                  ),
                ),
                InkWell(
                  onTap: () {
                    AppSnackBar().showSnackBar("No website yet", context);
                  },
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
    );
  }
}
