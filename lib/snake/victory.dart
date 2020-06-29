import 'package:flutter/widgets.dart';
import './game_constants.dart';

class Victory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: BOARD_SIZE,
      height: BOARD_SIZE,
      padding: const EdgeInsets.all(TEXT_PADDING),
      child: Center(
        child: Text(
          "Victory! Tap to play again!",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
