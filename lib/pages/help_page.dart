import 'package:cinepopapp/components/app_tool_bar.dart';

import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const Apptoolbar(title: "Help"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Wellcome to Dou-Khaber! \n"
                        "\n",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text:
                        "Please Refer below to find your answers if you don't find it here you can always contact us here Help@doukhaber.com.pk",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Navigating The App: \n"
                        "\n",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text:
                        "Home Feed: Its the section where yur posts and other's posts will be visible to you \n"
                        "\n"
                        "Chat: it's the section where you can start chatting with your friends and see your previous chats \n"
                        "\n"
                        "Add post: From here you can add a new post \n"
                        "\n"
                        "Search: From this section you can find other users and others posts"
                        "\n",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: "\n Posting: \n"
                        "\n",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text:
                        "Add Post: Go to Add post then select a photo,crop it and write a description about the photo and then hit add button \n"
                        "\n"
                        "Delete Post: Go to the post you want to delete then tap on 3 dots at upper right corner then from there select Delete option and then confirm the delete by clicking delete again \n"
                        "\n"
                        "Report Post: Go to the post you want to report then tap on 3 dots at upper right corner then from there select Report option \n"
                        "\n",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: "\n Update personal information: \n"
                        "\n",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text:
                        "Update info: Tap on edit from profile or from settings go to personal information , edit your information from there by clicking on setting icon at upper right corner , write new information and click update.\n"
                        "\n",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
