import 'package:flutter/widgets.dart';
import 'package:nokiapro/styles/app_colors.dart';
import './game_constants.dart';

class Apple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: PIECE_SIZE,
      height: PIECE_SIZE,
      decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(PIECE_SIZE)),
    );
  }
}
