import 'package:flutter/material.dart'; 

// import 'package:mock_investigation_case/core/data_discovery_lab_core/app_colors.dart';

class AppTheme { 
  static final ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: BrandingColor.blue50,
    fontFamily: 'Poppins',
  );
}

class AppColor {
  static Color get dark1 => colorFromHex('16212C');
  static Color get dark2 => colorFromHex('1F2E3D');
  static Color get dark3 => colorFromHex('233749');
  static Color get blueGrey1 => colorFromHex('344250');
  static Color get blueGrey2 => colorFromHex('4D5864');
  static Color get grey => colorFromHex('859399');
  static Color get white => colorFromHex('FFFFFF');
  static Color get black => colorFromHex('333333');
  static Color get blue => colorFromHex('1C80E3');
  static Color get blue50 => colorFromHex('F6F8FC');
  static Color get blue100 => colorFromHex('EEF1FC');
  static Color get lime => colorFromHex('B2F941');
  static Color get yellow => colorFromHex('FFFF00');
  static Color get orange => colorFromHex('F15A24');
  static Color get red => colorFromHex('9B3F23');
  static Color get bgWhite => colorFromHex('#f2f2f2');
  static Color get primaryRed => colorFromHex('#ab2328');
  static Color get bronze => colorFromHex('#9a6d43');
  static Color get cream => colorFromHex('#e9e3d3');
  static Color get greyLight => colorFromHex('#b0b0b0');
  static Color get greyDark => colorFromHex('#656565');
  static Color get shadow => greyLight.withOpacity(0.2);
}

class BrandingColor {
  static Color get blue50 => colorFromHex('#F6F8FC'); // bg

  static Color get blue100 => colorFromHex('#EEF1FC'); 

  static Color get blue300 => colorFromHex('#929EC7');

  static Color get blue500 => colorFromHex('#7E8AAA'); // side bar (based sa leads)

  static Color get blue700 => colorFromHex('#1440CD');

  static Color get blue900 => colorFromHex('#000926');

  static Color get grey1 => colorFromHex('#0000000D');

  static Color get grey2 => colorFromHex('#BBC4E2');

  static Color get grey3 => colorFromHex('#E6EBFA');

  static Color get grey4 => colorFromHex('#E6E9F4');

  static Color get grey5 => colorFromHex('#707070');

  static Color get darkblue => colorFromHex('#192A49');

  static Color get green900 => colorFromHex('#40B900');

  static Color get orange900 => colorFromHex('#F26309');

  static Color get red => colorFromHex('#F04858');

  static Color get logo => colorFromHex('#245484');
}

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
