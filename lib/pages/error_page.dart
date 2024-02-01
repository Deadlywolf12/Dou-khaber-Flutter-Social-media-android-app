import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String load;
  const ErrorPage({super.key, required this.load});

  @override
  Widget build(BuildContext context) {
    return buildUi();
  }

  Widget buildUi() {
    if (load.isNotEmpty) {
      return Container(
          color: Color.fromARGB(255, 46, 46, 45),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  load,
                  style: TextStyle(color: Colors.white),
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                )
              ],
            ),
          ));
    } else {
      return Text("");
    }
  }
}
