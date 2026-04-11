import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellbot/core/utils/constants/app_colors.dart';
import 'package:wellbot/core/utils/theme/custom_text_style.dart';


class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: CustomTextStyles.orelegaOne32White,
      ),

      textTheme: GoogleFonts.nunitoTextTheme().apply(
        bodyColor: AppColors.primaryTextColor,
        displayColor: AppColors.primaryTextColor,
      ),
    );
  }
}