import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recyclo/config/app_config.dart';
import 'package:recyclo/routes/approutes.dart';
import 'package:recyclo/theme/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        AppConfig(
          designScreenWidth: 392,
          designScreenHeight: 781,
        ).init(context, constraints, orientation);

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Recyclo',
          theme: Themes.light(context),
          initialRoute: AppRoutes.mainscreen,
          getPages: AppRoutes.routes,
        );
      });
    });
  }
}
