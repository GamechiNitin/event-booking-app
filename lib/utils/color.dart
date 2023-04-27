import 'package:adda/utils/dimens.dart';
import 'package:flutter/material.dart';

MaterialColor kSwatchColor = Colors.lightBlue;
Color kPrimaryColor = const Color.fromARGB(255, 7, 42, 58);
Color kWhiteColor = Colors.white;
Color kRedColor = Colors.redAccent;
Color kBlueColor = Colors.blue;
Color kLightGreenColor = kBlueColor;
Color kBorderColor = Colors.grey.shade600;
Color kGreyColor = Colors.grey.shade600;
Color kLightGreyColor = Colors.grey.shade300;

// Decoration
InputBorder kBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(kBorderRadius),
  borderSide: BorderSide(
    width: kBorderWidth,
    color: kBorderColor,
  ),
);
InputBorder kErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(kBorderRadius),
  borderSide: BorderSide(
    width: kBorderWidth,
    color: kRedColor,
  ),
);
// DEcoration
InputBorder kFocusBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(kBorderRadius),
  borderSide: BorderSide(
    width: kBorderWidth,
    color: kLightGreenColor,
  ),
);
