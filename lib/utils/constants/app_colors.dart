  import 'package:flutter/material.dart';

  class AppColors {
    AppColors._();
    static const Color primaryColor = Color(0xFFFE8800);
    static const Color hintTextColor = Color(0xFF838383);
    static const Color primaryTextColor = Color(0xFF1B1B1B);
    static const LinearGradient primaryGradient = LinearGradient(
      colors: [
        Color(0xFFFEC380), 
        Color(0xFFFEA033), 
        Color(0xFFFE8800), 
      ],
      stops: [0.0, 0.17, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    static const Color unselectedTextColor = Color(0xB3000000); 
    static const LinearGradient mainAppTransitionBackgroundGradient = LinearGradient(
      colors: [
        Color(0xFFFEA033),
        Color(0xFFF7AF5B), 
        Color(0xFFFE8800), 
      ],
      stops: [0.17, 0.25, 0.80],
      begin: Alignment.centerLeft, 
      end: Alignment.centerRight,
    );
    static const Color locationLineColor = Color(0xB3EF9F27); 
    static const Color commentAndSettingsBackground = Color(0x4DD79C1D);
    static const Color primaryBorderColor = Color(0xFFD79C1D);
  }
