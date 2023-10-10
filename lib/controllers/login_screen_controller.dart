import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:recyclo/constants/color_constants.dart';
import 'package:recyclo/routes/approutes.dart';
import 'package:recyclo/services/apihandler.dart';
import 'package:http/http.dart' as http;

class LoginScreenController extends GetxController {
  bool passwordVisbility = false;
  final storage = const FlutterSecureStorage();
  void loginVisibility() {
    passwordVisbility = !passwordVisbility;
    update();
  }

  Future<void> loginRequest(BuildContext context, sendingBody) async {
    try {
      String uri = APIConstants.baseURI + APIConstants.customerLogin;
      var response = await http.post(Uri.parse(uri), body: sendingBody);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await storage.write(
            key: 'refreshtoken', value: data['token']['refresh'].toString());
        await storage.write(
            key: 'accesstoken', value: data['token']['access'].toString());
        Get.offAllNamed(AppRoutes.mainscreen);
      } else if (response.statusCode == 400) {
        Map data = jsonDecode(response.body);

        if (data.containsKey('errors')) {
          Get.snackbar(
            'Error',
            data['errors']['non_field_errors'][0],
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConstants.kPlaneWhiteColor,
            backgroundColor: ColorConstants.KErrorColor,
          );
        } else if (data.containsKey("email")) {
          Get.snackbar(
            'Error',
            data['email'],
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConstants.kPlaneWhiteColor,
            backgroundColor: ColorConstants.KErrorColor,
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
