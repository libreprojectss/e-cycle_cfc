import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recyclo/constants/color_constants.dart';
import 'package:recyclo/routes/approutes.dart';
import 'package:recyclo/services/apihandler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpScreenController extends GetxController {
  bool passwordVisbility = false;
  final storage = const FlutterSecureStorage();

  void signupVisibility() {
    passwordVisbility = !passwordVisbility;
    update();
  }

  Future<void> signUpRequest(BuildContext context, sendingBody) async {
    try {
      String uri = APIConstants.baseURI + APIConstants.customerSignUp;
      var response = await http.post(Uri.parse(uri), body: sendingBody);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Get.back();
        Get.offAllNamed(AppRoutes.mainscreen);
        await storage.write(
            key: 'refreshtoken', value: data['token']['refresh'].toString());
        await storage.write(
            key: 'accesstoken', value: data['token']['access'].toString());
      } else {
        Get.back();
        Get.snackbar(
          'Error',
          'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.kPlaneWhiteColor,
          backgroundColor: ColorConstants.KErrorColor,
        );
      }
    } catch (e) {
      Get.back();
      debugPrint(e.toString());
    }
  }
}
