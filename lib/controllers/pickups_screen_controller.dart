import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:recyclo/services/apihandler.dart';
import 'package:http/http.dart' as http;

class PickupScreenController extends GetxController {
  final storage = const FlutterSecureStorage();
  List pickups = [];
  void getPickupDetails() async {
    final accessToken = await storage.read(key: 'accesstoken');
    String uri = APIConstants.baseURI + APIConstants.customerPickupsView;
    var response = await http.get(
      Uri.parse(uri),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    debugPrint(response.body, wrapWidth: 800);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var productsData = jsonData['data'][0]['products'];
      pickups = productsData;

      update();
    } else {
      // Handle the case where the response status code is not 200
      print("Error: ${response.statusCode}");
    }
  }
}
