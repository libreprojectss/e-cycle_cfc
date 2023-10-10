import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recyclo/controllers/mainscreen_controller.dart';

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
                selectedIcon: Icon(Icons.dashboard_customize_outlined),
                icon: Icon(Icons.dashboard),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.my_location_outlined),
                icon: Icon(Icons.location_on_outlined),
                label: 'Maps',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.history_outlined),
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