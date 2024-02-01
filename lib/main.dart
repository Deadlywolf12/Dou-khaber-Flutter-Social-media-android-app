import 'package:cinepopapp/components/theme/app_theme.dart';

import 'package:cinepopapp/config/resources/app_routes.dart';
import 'package:cinepopapp/config/resources/app_strings.dart';
import 'package:cinepopapp/config/providers/user_provider.dart';

import 'package:cinepopapp/utils/controller/dependency_Injection.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'config/resources/firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: Appstrings.appName,
        theme: lightMode,
        darkTheme: darkMode,
        initialRoute: Approutes.splash,
        routes: Approutes.pages,
      ),
    );
  }
}
