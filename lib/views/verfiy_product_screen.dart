import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recyclo/config/ext.dart';
import 'package:recyclo/constants/color_constants.dart';
import 'package:recyclo/controllers/add_product_screen_controller.dart';
import 'package:recyclo/routes/approutes.dart';
import 'package:recyclo/utils/custom_button.dart';

class VerifyProductScreen extends StatefulWidget {
  const VerifyProductScreen({super.key});

  @override
  State<VerifyProductScreen> createState() => _VerifyProductScreenState();
}

class _VerifyProductScreenState extends State<VerifyProductScreen> {
  final AddProductScreenController addProductScreenController =
      Get.find<AddProductScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Added Products'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: addProductScreenController.products.length,
                itemBuilder: (context, index) {
                  final product = addProductScreenController.products[index];

                  return Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: ListTile(
                        title: Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          product.description,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: ColorConstants.KtextColor),
                        ),
                        leading: Image.file(
                          product.image!,
                          width: 120.w, // Adjust the width as needed
                          height: 150.h, // Adjust the height as needed
                          fit: BoxFit.cover,
                        )),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
              ),
              onPressed: () {
                addProductScreenController.productname.clear();
                addProductScreenController.productdescription.clear();
                Get.back();
              },
              child: const Text('Add another product')),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
            child: CustomButton(
                text: 'Continue',
                onClick: () {
                  Get.toNamed(AppRoutes.submitproduct);
                }),
          )
        ],
      ),
    );
  }
}
