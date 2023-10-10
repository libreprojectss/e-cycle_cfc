import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:recyclo/routes/approutes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = const FlutterSecureStorage();
  void checkTokens() async {
    // Check if the tokens are present in the storage
    final refreshToken = await storage.read(key: 'refreshtoken');
    final accessToken = await storage.read(key: 'accesstoken');

    if (refreshToken != null && accessToken != null) {
      Get.offAllNamed(AppRoutes.mainscreen);
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.offAllNamed(AppRoutes.loginscreen);
      });
    }
  }

  @override
  void initState() {
    checkTokens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
