import 'package:flutter/material.dart';
import 'package:recyclo/constants/color_constants.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  @override
  Widget build(BuildContext context) {
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
  }
}
