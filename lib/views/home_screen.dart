import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recyclo/routes/approutes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.addproduct);
        },
        label: Text(
          'Add',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        icon: const Icon(Icons.add_box_outlined),
      ),
    );
  }
}
