import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/cache_service.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class ThemeService extends GetxService {
  final _key = 'isDarkMode';

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => CacheService.getBool(_key);
  _saveThemeToBox(bool isDarkMode) => CacheService.setBool(_key, isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      cardColor: const Color(0xFFFBFBFB),
      textTheme: AppTextStyles.lightTextTheme,
      dividerColor: const Color(0xFFE6E6E6),
      iconTheme: const IconThemeData(color: AppColors.textColor),
      primaryIconTheme: const IconThemeData(color: AppColors.textColor),
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(foregroundColor: AppColors.textColor)),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.textColor,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark();
  }
}
