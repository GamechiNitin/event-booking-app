import 'package:adda/utils/color.dart';
import 'package:adda/utils/dimens.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
    // primarySwatch: kSwatchColor,
    useMaterial3: true,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: kWhiteColor,
        fontSize: size16,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: kWhiteColor,
      ),
    ),

    //
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: kPrimaryColor,
      background: ColorScheme.fromSeed(seedColor: kPrimaryColor).background,
      onBackground: ColorScheme.fromSeed(seedColor: kPrimaryColor).onBackground,
      error: ColorScheme.fromSeed(seedColor: kPrimaryColor).error,
      onError: ColorScheme.fromSeed(seedColor: kPrimaryColor).onError,
      onPrimary: ColorScheme.fromSeed(seedColor: kPrimaryColor).onPrimary,
      onSecondary: ColorScheme.fromSeed(seedColor: kPrimaryColor).onSecondary,
      onSurface: ColorScheme.fromSeed(seedColor: kPrimaryColor).onSurface,
      secondary: ColorScheme.fromSeed(seedColor: kPrimaryColor).secondary,
      surface: ColorScheme.fromSeed(seedColor: kPrimaryColor).surface,
      errorContainer:
          ColorScheme.fromSeed(seedColor: kPrimaryColor).errorContainer,
    ),
    scaffoldBackgroundColor:
        ColorScheme.fromSeed(seedColor: kPrimaryColor).background,
  );
}
