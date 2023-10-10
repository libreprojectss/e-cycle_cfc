import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recyclo/controllers/mainscreen_controller.dart';
import 'package:unicons/unicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainScreenController mainScreenController =
      Get.put(MainScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(
      builder: (controller) {
        Widget currentPage = controller.getPage(controller.currentIndex);
        return Scaffold(
          body: currentPage,
          bottomNavigationBar: NavigationBar(
            selectedIndex: mainScreenController.currentIndex,
            onDestinationSelected: (value) {
              mainScreenController.changeIndex(value);
            },
            destinations: const <NavigationDestination>[
              NavigationDestination(
                selectedIcon: Icon(UniconsLine.home),
                icon: Icon(UniconsLine.home_alt),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(UniconsLine.map_marker_shield),
                icon: Icon(UniconsLine.map_marker_shield),
                label: 'Maps',
              ),
              NavigationDestination(
                selectedIcon: Icon(UniconsLine.history),
                icon: Icon(Icons.history_outlined),
                label: 'Pickups',
              ),
            ],
          ),
        );
      },
    );
  }
}
