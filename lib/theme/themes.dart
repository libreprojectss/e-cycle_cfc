import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recyclo/constants/color_constants.dart';
import 'package:recyclo/theme/textstyle.dart';

class Themes {
  static ThemeData light(BuildContext context) {
    return ThemeData.light().copyWith(
      useMaterial3: true,
      iconTheme: const IconThemeData(color: Colors.black),
      primaryColor: ColorConstants.kPrimaryColor,
      colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstants.kPrimaryColor.withOpacity(0.5)),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),

      // Use GoogleFonts widget to set the font family
      textTheme: GoogleFonts.urbanistTextTheme(
        Theme.of(context).textTheme.copyWith(
            titleLarge: AppTextStyles.titleLarge
                .copyWith(color: ColorConstants.kPlaneWhiteColor),
            titleMedium: AppTextStyles.titleMedium
                .copyWith(color: ColorConstants.KtextColor),
            labelMedium: AppTextStyles.inputHintLabel
                .copyWith(color: ColorConstants.KInputLabelColor),
            titleSmall: AppTextStyles.titleSmall),
      ),
    );
  }
}
