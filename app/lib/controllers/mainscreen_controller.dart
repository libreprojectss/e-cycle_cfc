import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:recyclo/views/home_screen.dart';
import 'package:recyclo/views/landing_screen.dart';
import 'package:recyclo/views/pickups_screen.dart';

class MainScreenController extends GetxController {
  var currentIndex = 0;
  final List<Widget> pages = [
    const HomeScreen(),
    const LandingScreen(),
    const PickupScreen()
  ];
  void changeIndex(int index) {
    currentIndex = index;

    update();
  }

  Widget getPage(int index) {
    return pages[index];
  }
}
