import 'package:flutter/material.dart';

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

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
