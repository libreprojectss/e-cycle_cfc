import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:recyclo/constants/color_constants.dart';
import 'package:recyclo/models/location_model.dart';
import 'package:recyclo/models/products.dart';
import 'package:http/http.dart' as http;
import 'package:recyclo/routes/approutes.dart';
import 'package:recyclo/services/apihandler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddProductScreenController extends GetxController {
  TextEditingController productname = TextEditingController();
  TextEditingController productdescription = TextEditingController();
  TextEditingController location = TextEditingController();
  final List<Product> products = <Product>[].obs;
  RxBool isloading = false.obs;
  RxBool isUsable = true.obs;
  List<String> descriptions = [];
  List<String> placeid = [];
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  void addProduct(Product product) {
    products.add(product);
  }

  Future<void> placeAutoComplete(BuildContext context, String query) async {
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      "input": query,
      "components": "country:np",
      "types": "establishment",
      "key": "${dotenv.env['placeskey']}",
    });

    String? response = await fetchUrl(uri);
    if (response != null) {
      final data = jsonDecode(response);

      final predictions = data['predictions'];
      descriptions = predictions
          .map<String>((prediction) => prediction['description'] as String)
          .toList();
      placeid = predictions
          .map<String>((prediction) => prediction['place_id'] as String)
          .toList();
      update();
    }
  }

  void fetchGeocodingData(String placeid) async {
    final String apiKey = '${dotenv.env['geocodingkey']}';
    String placeId = placeid;

    final Uri uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=$apiKey');

    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final storeData = StoreData.fromJson(data);
        longitude.text = storeData.longitude.toString();
        latitude.text = storeData.latitude.toString();
        update();
        sendProductData(products);
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
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
        {
          'products': requestData,
          'lat': double.tryParse(latitude.text),
          'long': double.tryParse(longitude.text)
        },
      );

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      final responseContent = jsonDecode(response.body);
      debugPrint('Response Content: $responseContent');

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Product added successfully',
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConstants.kPlaneWhiteColor,
            backgroundColor: ColorConstants.kPrimaryColor);
        Get.offAllNamed(AppRoutes.mainscreen);
        // All products sent successfully
      } else {
        isloading.value = false;
        Get.back();
        Get.snackbar('Error', 'Something went wrong',
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConstants.kPlaneWhiteColor,
            backgroundColor: ColorConstants.KErrorColor);
        // Handle the case where the request was not successful
      }
    } catch (e) {
      isloading.value = false;
      Get.back();
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.kPlaneWhiteColor,
          backgroundColor: ColorConstants.KErrorColor);
      debugPrint(e.toString());
      // Handle any errors that occurred during the sending process
    }
  }
}
