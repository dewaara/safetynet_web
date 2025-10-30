import 'package:flutter/material.dart';

class Styles {
  static Color scaffoldBackgroundColor = const Color(0xffc1dbf0);
  static Color defaultRedColor = const Color(0xffd8315b);
  static Color defaultYellowColor = const Color(0xfffcba03);
  static Color defaultBlueColor = const Color(0xff52beff);
  static Color defaultGreyColor = const Color(0xff77839a);
  static Color defaultLightGreyColor = const Color(0xffc4c4c4);
  static Color defaultLightWhiteColor = const Color(0xFFf2f6fe);

  static double defaultPadding = 18.0;

  static BorderRadius defaultBorderRadius = BorderRadius.circular(20);

  static ScrollbarThemeData scrollbarTheme = ScrollbarThemeData(
    thumbColor: WidgetStateProperty.all(defaultYellowColor),
    interactive: true,
  );
}
