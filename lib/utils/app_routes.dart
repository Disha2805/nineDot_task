import 'package:get/get.dart';
import 'package:ninedot_task/screens/home/binding/home_bindings.dart';
import 'package:ninedot_task/screens/home/home_screen.dart';
import 'package:ninedot_task/screens/login/binding/login_bindings.dart';
import 'package:ninedot_task/screens/login/login_screen.dart';
import 'package:ninedot_task/screens/sign_up/binding/sign_up_bindings.dart';
import 'package:ninedot_task/screens/sign_up/sign_up_screen.dart';

class Routes {
  static String login = "/loginScreen";
  static String signUp = "/signUpScreen";
  static String home = "/homeScreen";

  static List<GetPage> routes = [
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
      transition: Transition.fadeIn,
    ),
  ];
}
