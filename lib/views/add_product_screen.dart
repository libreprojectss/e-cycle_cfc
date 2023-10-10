import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recyclo/config/ext.dart';
import 'package:recyclo/controllers/add_product_screen_controller.dart';
import 'package:recyclo/models/products.dart';
import 'package:recyclo/routes/approutes.dart';
import 'package:recyclo/utils/custom_button.dart';
import 'package:recyclo/utils/input_field.dart';
import 'package:recyclo/constants/color_constants.dart';

import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

  File? _image;
  // File? _compressImage;
  String compressImagePath = "/storage/emulated/0/Download";
  Future getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);

      setState(() {}); // Trigger a UI update
    }

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // _testCompressAndGetFile(_image!, compressImagePath);
  }

  // Future<File?> _testCompressAndGetFile(File file, String targetPath) async {
  //   final filePath = file.path;
  //   final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  //   final splitted = filePath.substring(0, (lastIndex));
  //   final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     outPath,
  //     quality: 88,
  //     rotate: 180,
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  final AddProductScreenController addProductScreenController =
      Get.put(AddProductScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: Form(
            key: _formKey3,
            child: Column(
              children: [
                // SizedBox(
                //   height: 40.h,
                // ),
                Row(
                  children: [
                    Text('Product Name',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                InputField(
                    onChanged: (value) {},
                    controller: addProductScreenController.productname,
                    errorText: null,
                    hintText: 'Enter the product name',
                    keywordType: TextInputType.name,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required ';
                      } else {
                        return null;
                      }
                    },
                    obscureText: false,
                    isPrefix: false,
                    readonly: false),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Text('Description',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                InputField(
                    onChanged: (value) {},
                    controller: addProductScreenController.productdescription,
                    errorText: null,
                    hintText: 'Enter the product description',
                    keywordType: TextInputType.name,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required ';
                      } else {
                        return null;
                      }
                    },
                    obscureText: false,
                    isPrefix: false,
                    readonly: false),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Text('Photo',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => bottomSheet(getImage),
                        );
                      },
                      child: Container(
                        width: 200.w,
                        height: 150.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: _image == null ? 0.5 : 0,
                                color: ColorConstants.kPrimaryColor)),
                        child: _image == null
                            ? Center(
                                child: TextButton.icon(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          bottomSheet(getImage),
                                    );
                                  },
                                  label: const Text(
                                    'Add photo',
                                  ),
                                  icon: const Icon(Icons.add_a_photo_outlined),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    _image != null
                        ? ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                            ),
                            onPressed: () {
                              _image = null;
                              setState(() {});
                            },
                            child: Text(
                              'Remove',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: ColorConstants.kPrimaryColor),
                            ))
                        : const SizedBox(),
                  ],
                ),

                SizedBox(
                  height: 130.h,
                ),
                CustomButton(
                    text: 'Continue',
                    onClick: () {
                      final isvalid = _formKey3.currentState!.validate();
                      if (isvalid && _image != null) {
                        FocusScope.of(context).unfocus();
                        final productName =
                            addProductScreenController.productname.text;
                        final productDescription =
                            addProductScreenController.productdescription.text;
                        final usable =
                            addProductScreenController.isUsable.value;
                        final productImage = _image;

                        final newProduct = Product(
                          name: productName,
                          description: productDescription,
                          usable: usable,
                          image: productImage,
                        );
                        addProductScreenController.addProduct(newProduct);

                        Get.toNamed(AppRoutes.verifyproduct);
                        addProductScreenController.productname.clear();
                        addProductScreenController.productdescription.clear();
                        addProductScreenController.isUsable.value = true;
                        _image = null;
                      } else if (isvalid && _image == null) {
                        Get.snackbar(
                          'Error',
                          'Please add the image',
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: ColorConstants.kPlaneWhiteColor,
                          backgroundColor: ColorConstants.KErrorColor,
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget bottomSheet(Function(ImageSource) getImage) {
  return Builder(builder: (context) {
    return Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: <Widget>[
          Text(
            'Choose image',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
                ),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: const Icon(
                  Icons.camera,
                  size: 17,
                ),
                label: const Text(
                  'Camera',
                ),
              ),
              ElevatedButton.icon(
                  style: ButtonStyle(
                    // backgroundColor: MaterialStateProperty.all<Color>(),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
                  ),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  icon: const Icon(
                    LineAwesomeIcons.image,
                    size: 17,
                  ),
                  label: const Text(
                    'Gallery',
                  ))
            ],
          )
        ],
      ),
    );
  });
}
