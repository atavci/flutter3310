import 'package:flutter/widgets.dart';
import './game_constants.dart';

class Failure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: BOARD_SIZE,
      height: BOARD_SIZE,
      padding: const EdgeInsets.all(TEXT_PADDING),
      child: Center(
        child: Text(
          "Game over! Tap to play again!",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
