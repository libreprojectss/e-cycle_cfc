import 'dart:async';
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
  Timer? _debounce;
  void _onTextChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      // Call your function here after a delay of 5 seconds.
      // FocusScope.of(context).unfocus();
      addProductScreenController.placeAutoComplete(context, value);
    });
  }

  @override
  // void dispose() {
  //   _debounce?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductScreenController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Submit Products'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Enter your location',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: ColorConstants.KtextColor)),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              InputField(
                  onChanged: (value) {
                    _onTextChanged(value.toString());
                  },
                  controller: addProductScreenController.location,
                  errorText: null,
                  hintText: 'Enter your location',
                  keywordType: TextInputType.name,
                  validation: (value) {},
                  obscureText: false,
                  isPrefix: false,
                  readonly: false),
              SizedBox(
                height: 20.h,
              ),
              addProductScreenController.descriptions.isNotEmpty
                  ? Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Select one of the location',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: ColorConstants.KtextColor)),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: addProductScreenController
                                  .descriptions.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.symmetric(vertical: 15.h),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onTap: () {
                                      // addProductScreenController
                                      //     .fetchGeocodingData(
                                      //         addProductScreenController
                                      //             .placeid[index]);
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Obx(() => AlertDialog(
                                                title: const Text(
                                                    'Are you sure to submit the product?'),
                                                content:
                                                    const SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(
                                                          'Your product will be collected at the selected location.'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('CANCEL'),
                                                    onPressed: () {
                                                      addProductScreenController
                                                          .isloading
                                                          .value = false;
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  addProductScreenController
                                                          .isloading.value
                                                      ? SizedBox(
                                                          width: 22.w,
                                                          height: 20.h,
                                                          child:
                                                              const CircularProgressIndicator(
                                                            strokeWidth: 1.8,
                                                          ))
                                                      : TextButton(
                                                          child:
                                                              const Text('YES'),
                                                          onPressed: () {
                                                            addProductScreenController
                                                                .isloading
                                                                .value = true;
                                                            addProductScreenController
                                                                .fetchGeocodingData(
                                                                    addProductScreenController
                                                                            .placeid[
                                                                        index]);
                                                            // Navigator.of(context)
                                                            //     .pop();
                                                          },
                                                        ),
                                                ],
                                              ));
                                        },
                                      );
                                    },
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          addProductScreenController
                                              .descriptions[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: ColorConstants
                                                      .KtextColor),
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
                    )
                  : const SizedBox()
            ],
          ),
        ),
      );
    });
  }
}
