import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSVG {
  static String signal = 'assets/svg/Signal.svg';
  static String barSmall = 'assets/svg/BarSmall.svg';
  static String barMedium = 'assets/svg/BarMedium.svg';
  static String barLarge = 'assets/svg/BarLarge.svg';
  static String barLargest = 'assets/svg/BarLargest.svg';
  static String battery = 'assets/svg/Battery.svg';

  static Widget getSVG(String svgName,{double height=25}) {
    return SvgPicture.asset(
      svgName,
      semanticsLabel: svgName,
      height: height,
    );
  }
}
