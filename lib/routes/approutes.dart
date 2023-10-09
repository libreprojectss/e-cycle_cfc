import 'package:get/get.dart';
import 'package:recyclo/views/landing_screen.dart';
import 'package:recyclo/views/login_screen.dart';
import 'package:recyclo/views/mainscreen.dart';
import 'package:recyclo/views/signup_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String landingscreen = '/landingscreen';
  static const String loginscreen = '/loginscreen';
  static const String signupscreen = '/signupscreen';
  static const String mainscreen = '/mainscreen';
  static final List<GetPage> routes = [
    // GetPage(
    //   name: splash,
    //   page: () => const SplashScreen(),
    //   binding: SplashBinding(),
    // ),
    GetPage(
      name: landingscreen,
      page: () => const LandingScreen(),
      binding: LandingScreenBinding(),
    ),
    GetPage(
      name: loginscreen,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: signupscreen,
      page: () => const SignUpScreen(),
      binding: SignUpScreenBinding(),
    ),
    GetPage(
      name: mainscreen,
      page: () => const MainScreen(),
      binding: SignUpScreenBinding(),
    ),
  ];
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Splash screen can be added here
  }
}

class LandingScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Landing screen can be added here
  }
}

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Login screen can be added here
  }
}

class SignUpScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Login screen can be added here
  }
}

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Login screen can be added here
  }
}
