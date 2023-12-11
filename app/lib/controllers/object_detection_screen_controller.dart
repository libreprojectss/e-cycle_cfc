import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recyclo/helpers/image_picker.dart';
import 'package:recyclo/services/apihandler.dart';
import 'package:http/http.dart' as http;

class ObjectDetectionScreenController extends GetxController {
  Rx<Uint8List?> pickedImage = Rx<Uint8List?>(Uint8List(0));
  Rx<String?> filePath = Rx<String?>('');
  RxBool isLoading = false.obs;
  ObjectDetectionScreenController();
  Rx<List<dynamic>?> detectionResult = Rx<List<dynamic>?>([]);
  Rx<String?> detectedImageUrl = Rx<String?>('');

  Future<void> pickImageFromCamera() async {
    final imageProcessor = ImageProcessor();

    ImagePick? result = await imageProcessor.pickImage(ImageSource.camera);
    if (result != null) {
      pickedImage.value = result.compressedImageData;
      filePath.value = result.filePath;
      detectionResult.value!.clear();
      detectedImageUrl.value = '';

      // Use imageData and base64String as needed
    } else {}
  }

  Future<void> pickImageFromGallery() async {
    final imageProcessor = ImageProcessor();

    ImagePick? result = await imageProcessor.pickImage(ImageSource.gallery);
    if (result != null) {
      pickedImage.value = result.compressedImageData;
      filePath.value = result.filePath;
      detectionResult.value!.clear();
      detectedImageUrl.value = '';
    } else {}
  }

  Future<void> detectImage() async {
    try {
      isLoading.value = true;
      String uri = APIConstants.baseURI + APIConstants.objectDetectionModel;
      var request = http.MultipartRequest('POST', Uri.parse(uri));

      if (pickedImage.value != null && pickedImage.value!.isNotEmpty) {
        var file = await http.MultipartFile.fromPath(
          'image',
          filePath.value!,
        );
        request.files.add(file);
      } else {
        isLoading.value = false;
        debugPrint("No image selected");
        return;
      }

      var response = await request.send();
      final responseJson = await http.Response.fromStream(response);

      var results = jsonDecode(responseJson.body);

      if (response.statusCode == 200) {
        detectionResult.value = results['result']['result'];
        detectedImageUrl.value = results['result']['image'];
        // Handle successful response
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // Handle unsuccessful response
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
