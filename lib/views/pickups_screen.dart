import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    // TODO: implement initState
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
      );
    });
  }
}
