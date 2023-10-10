import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:recyclo/config/ext.dart';
import 'package:recyclo/constants/color_constants.dart';
import 'package:recyclo/models/products.dart';
import 'package:http/http.dart' as http;
import 'package:recyclo/services/apihandler.dart';

class AddProductScreenController extends GetxController {
  TextEditingController productname = TextEditingController();
  TextEditingController productdescription = TextEditingController();
  TextEditingController location = TextEditingController();
  final List<Product> products = <Product>[].obs;
  List<String> descriptions = [];
  Timer? _debounce;
  void addProduct(Product product) {
    products.add(product);
  }

  Future<void> placeAutoComplete(BuildContext context, String query) async {
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      "input": query,
      "components": "country:np",
      "types": "establishment",
      "key": "AIzaSyDtgBiZs81Fy4xRQtOzBHh0JjHR8S_HJa4",
    });

    String? response = await fetchUrl(uri);
    if (response != null) {
      final data = jsonDecode(response);

      final predictions = data['predictions'];
      descriptions = predictions
          .map<String>((prediction) => prediction['description'] as String)
          .toList();
    }

    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Please select one of above the locations',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: ColorConstants.KtextColor),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: descriptions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 15.h),
                        child: ListTile(
                          title: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    descriptions[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: ColorConstants.KtextColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
  try {
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

Future<void> sendProductData(List<Product> productList) async {
  try {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'accesstoken');
    const apiUrl = APIConstants.baseURI + APIConstants.customerPickups;

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    final requestData = <Map<String, dynamic>>[];

    // Add product data and image for each product in the productList
    for (final product in productList) {
      final productData = {
        'title': product.name,
        'description': product.description,
        'usable': 'true',
      };

      // Attach the image to the product data if it exists for this product
      if (product.image != null) {
        final imageFile = product.image!;
        final imageBytes = await imageFile.readAsBytes();
        final base64Image = base64Encode(imageBytes);
        productData['image_64'] = base64Image;
      }

      requestData.add(productData);
    }

    final requestBody = jsonEncode(
      {'products': requestData, 'lat': '22', 'long': '22'},
    );

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: requestBody,
    );

    final responseContent = jsonDecode(response.body);
    debugPrint('Response Content: $responseContent');

    if (response.statusCode == 200) {
      // All products sent successfully
    } else {
      // Handle the case where the request was not successful
    }
  } catch (e) {
    // Handle any errors that occurred during the sending process
  }
}
