import 'package:get/get.dart';
import 'package:recyclo/views/add_product_screen.dart';
import 'package:recyclo/views/login_screen.dart';
import 'package:recyclo/views/mainscreen.dart';
import 'package:recyclo/views/signup_screen.dart';
import 'package:recyclo/views/splash_screen.dart';
import 'package:recyclo/views/submit_products.dart';
import 'package:recyclo/views/verfiy_product_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String landingscreen = '/landingscreen';
  static const String loginscreen = '/loginscreen';
  static const String signupscreen = '/signupscreen';
  static const String mainscreen = '/mainscreen';
  static const String addproduct = '/addproduct';
  static const String verifyproduct = '/verifyproduct';
  static const String submitproduct = '/submit';
  static final List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
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
    GetPage(
      name: addproduct,
      page: () => const AddProduct(),
      binding: AddProductScreenBinding(),
    ),
    GetPage(
      name: verifyproduct,
      page: () => const VerifyProductScreen(),
      binding: VerifyProductScreenBinding(),
    ),
    GetPage(
      name: submitproduct,
      page: () => const SubmitProducts(),
      binding: SubmitProductScreenBinding(),
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
    // Dependencies for the SignUp screen can be added here
  }
}

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Main Screen can be added here
  }
}

class AddProductScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the AddProducts screen can be added here
  }
}

class VerifyProductScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the VerifyProducts screen can be added here
  }
}

class SubmitProductScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the SubmitProducts screen can be added here
  }
}
