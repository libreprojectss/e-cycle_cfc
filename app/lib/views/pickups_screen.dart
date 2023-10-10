import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recyclo/config/ext.dart';
import 'package:recyclo/constants/color_constants.dart';
import 'package:recyclo/controllers/pickups_screen_controller.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final PickupScreenController pickupScreenController =
      Get.put(PickupScreenController());

  @override
  void initState() {
    pickupScreenController.getPickupDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PickupScreenController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pickups',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: ColorConstants.KtextColor),
          ),
        ),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
            itemCount: pickupScreenController.pickups.length,
            itemBuilder: (context, index) {
              var imageUrl = pickupScreenController.pickups[index]['image'];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 20..w, vertical: 10.h),
                child: ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            // ignore: prefer_interpolation_to_compose_strings
                            'http://192.168.1.30:8000/media/' + imageUrl,
                            scale: 3,
                            height: 100.h,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                // Image has finished loading, so show the image with ClipRRect
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: child,
                                );
                              } else {
                                // Image is still loading, show a CircularProgressIndicator
                                return const CircularProgressIndicator(
                                  strokeWidth: 2,
                                );
                              }
                            },
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              // Handle errors here (e.g., display a placeholder image)
                              return const Icon(Icons
                                  .error); // You can replace this with your error handling logic
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pickupScreenController.pickups[index]['title'],
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                pickupScreenController.pickups[index]
                                    ['description'],
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: ColorConstants.KtextColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ))
        ]),
      );
    });
  }
}
