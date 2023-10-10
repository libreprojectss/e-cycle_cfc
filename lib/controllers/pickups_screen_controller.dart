import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:recyclo/services/apihandler.dart';
import 'package:http/http.dart' as http;

class PickupScreenController extends GetxController {
  final storage = const FlutterSecureStorage();

  void getPickupDetails() async {
    final accessToken = await storage.read(key: 'accesstoken');
    String uri = APIConstants.baseURI + APIConstants.customerPickupsView;
    var response = await http.get(
        Uri.parse(
          uri,
        ),
        headers: {
          'Authorization': 'Bearer $accessToken',
        });
    print(response.body);
    if (response.statusCode == 200) {}
    debugPrint(response.body);
  }
}
