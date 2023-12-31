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
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              product.image!,
                              width: 80.w,
                              height: 100.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: ColorConstants.KtextColor),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                product.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: ColorConstants.KtextColor),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                product.usable == true ? 'Usable' : 'Unusable',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: ColorConstants.KtextColor),
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
