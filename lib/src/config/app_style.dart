import 'package:flutter/material.dart';
import 'package:radio_app/src/config/app_colors.dart';

class AppStyle{

static var mainTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    background: AppColors.background,
    onBackground: AppColors.onBackground,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    primaryContainer: AppColors.onPrimaryContainer,
    secondaryContainer: AppColors.secondaryContainer,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    
  )
);

static var textTheme = TextTheme(
  titleLarge: TextStyle(fontSize: 32,color: AppColors.primary, fontWeight: FontWeight.w500),
  bodyMedium: TextStyle(fontSize: 14,color: AppColors.onBackground),
  bodyLarge: TextStyle(fontSize: 18,color: AppColors.onBackground),
  labelSmall: TextStyle(fontSize: 10, color: AppColors.onPrimaryContainer),
  
);

}