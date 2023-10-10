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
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 20..w, vertical: 10.h),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pickupScreenController.pickups[index]['title'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              pickupScreenController.pickups[index]
                                  ['description'],
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: ColorConstants.KtextColor),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            pickupScreenController.pickups[index]
                                        ['description'] ==
                                    true
                                ? 'Usable'
                                : 'Un usable',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: ColorConstants.KtextColor),
                          )
                        ],
                      )
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
