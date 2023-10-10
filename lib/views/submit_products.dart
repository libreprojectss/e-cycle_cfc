import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recyclo/config/ext.dart';
import 'package:recyclo/constants/color_constants.dart';
import 'package:recyclo/utils/input_field.dart';

import '../controllers/add_product_screen_controller.dart';

class SubmitProducts extends StatefulWidget {
  const SubmitProducts({super.key});

  @override
  State<SubmitProducts> createState() => _SubmitProductsState();
}

class _SubmitProductsState extends State<SubmitProducts> {
  final AddProductScreenController addProductScreenController =
      Get.find<AddProductScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Products'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: Column(
          children: [
            Row(
              children: [
                Text('Add your location',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: ColorConstants.KtextColor)),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            InputField(
                onChanged: (value) {
                  addProductScreenController.placeAutoComplete(
                    context,
                    value.toString(),
                  );
                },
                controller: addProductScreenController.location,
                errorText: null,
                hintText: 'Enter your location',
                keywordType: TextInputType.name,
                validation: (value) {},
                obscureText: false,
                isPrefix: false,
                readonly: false)
          ],
        ),
      ),
    );
  }
}
