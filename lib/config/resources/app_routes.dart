import 'package:cinepopapp/pages/nav_page.dart';

import 'package:cinepopapp/pages/auth_page.dart';
import 'package:cinepopapp/pages/edit_profile_page.dart';

import '../../components/splash_screen.dart';
import '../../pages/about_page.dart';
import '../../pages/help_page.dart';
import '../../pages/settings_page.dart';
import '../../pages/validate_login_register_page.dart';

class Approutes {
  static final pages = {
    editpro: (context) => const Editprofile(),
    // userprofile: (context) => const Profilepage(),
    nav: (context) => const NavigationPage(),

    userAuth: (context) => const AuthPage(),
    validateAuth: (context) => const ValidateLoginRegister(),
    splash: (context) => const SplashScreen(),
    settings: (context) => const SettingsPage(),
    help: (context) => const Help(),
    about: (context) => const About(),
  };
  static const login = '/loginpage';
  static const home = '/homepage';
  static const userprofile = '/profile';
  static const editpro = '/editprofile';
  static const nav = '/nav';
  static const nearby = '/map';
  static const userAuth = '/auth';
  static const validateAuth = '/validateAuth';
  static const splash = '/splash';
  static const settings = '/settings';
  static const help = '/help';
  static const about = '/about';
}
