import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recyclo/controllers/landing_screen_controller.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final LandingScreenController landingScreenController =
      Get.put(LandingScreenController());

  @override
  void initState() {
    super.initState();
    landingScreenController.currentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingScreenController>(builder: (context) {
      return Scaffold(
        body: landingScreenController.latLng == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                    target: landingScreenController.latLng!, zoom: 18),
                markers: {
                    Marker(
                        markerId: const MarkerId('Current Location'),
                        position: landingScreenController.latLng!)
                  }),
      );
    });
  }
}
