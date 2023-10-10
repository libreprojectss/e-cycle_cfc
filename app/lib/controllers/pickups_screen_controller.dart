import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:recyclo/services/apihandler.dart';
import 'package:http/http.dart' as http;

class PickupScreenController extends GetxController {
  final storage = const FlutterSecureStorage();
  List<Map<String, dynamic>> pickups = []; // Change the type of pickups list
  void getPickupDetails() async {
    final accessToken = await storage.read(key: 'accesstoken');
    String uri = APIConstants.baseURI + APIConstants.customerPickupsView;
    var response = await http.get(
      Uri.parse(uri),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData['data'];
      // Clear the pickups list before adding new items
      pickups.clear();

      for (var item in data) {
        var productsData = item['products'];
        for (var product in productsData) {
          // Create a new map for each product and copy its values
          var newProduct = {
            'id': product['id'],
            'image': product['image'],
            'title': product['title'],
            'description': product['description'],
            'usable': product['usable'],
            'user': product['user'],
            'pickup': product['pickup'],
          };
          pickups.add(newProduct);
        }
      }

      // You can print the pickups list to check its contents
      print(pickups);
      update();
    } else {
      // Handle the case where the response status code is not 200
      print("Error: ${response.statusCode}");
    }
  }
}
