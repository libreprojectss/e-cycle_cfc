import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recyclo/config/ext.dart';
import 'package:recyclo/constants/color_constants.dart';
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
      appBar: AppBar(
        title: Text(
          'Welcome to Recyclo',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: ColorConstants.KtextColor),
        ),
      ),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeCard(
                image: 'assets/Ewaste.jpg',
                headertext: 'Recyclo',
                middleheader: 'Effortless E-Waste Recycling',
                lowerheader: 'Your Electronics, Our Commitment',
              ),
              SizedBox(height: 20.h),
              const HomeCard(
                image: 'assets/board.jpg',
                headertext: 'Recyclo',
                middleheader: 'Simplify. Collect. Renew',
                lowerheader: 'E-Waste Recycling Made Easy',
              ),
              SizedBox(height: 20.h),
              const HomeCard(
                image: 'assets/ewaste_collector.jpg',
                headertext: 'Recyclo',
                middleheader: 'Transforming E-Waste Responsibly',
                lowerheader: 'Your Convenience, Our Priority',
              ),
              SizedBox(height: 20.h),
              const HomeCard(
                image: 'assets/ewaste_dump.png',
                headertext: 'Recyclo',
                middleheader: 'Streamline Recycling Efforts',
                lowerheader: 'E-Waste Management Simplified',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.image,
    required this.headertext,
    required this.middleheader,
    required this.lowerheader,
  });
  final String image;
  final String headertext;
  final String middleheader;
  final String lowerheader;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Opacity(
                opacity: 0.6, // Adjust the opacity as needed
                child: Container(
                  color: Colors.black, // Color overlay for opacity effect
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                height: 50.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headertext,
                    maxLines: 4,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white), // White text color
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    middleheader,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontSize: 14.fontSize), // White text color
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    lowerheader,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 15.fontSize), // White text color
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
