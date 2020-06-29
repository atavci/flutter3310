import 'package:flutter/widgets.dart';
import 'package:nokiapro/game_model.dart';
import 'package:nokiapro/styles/app_colors.dart';
import 'package:provider/provider.dart';

import 'game_constants.dart';

class Board extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardState();
}

enum Direction { LEFT, RIGHT, UP, DOWN }
enum GameState { SPLASH, RUNNING, VICTORY, FAILURE }

class _BoardState extends State<Board> {
  GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    gameModel = Provider.of<GameModel>(context);

    return Container(
        color: AppColors.greenScreenColor,
        width: BOARD_SIZE,
        height: BOARD_SIZE,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (tapUpDetails) {
            gameModel.handleTap(tapUpDetails);
          },
          child: gameModel.getBoardChildBasedOnGameState(),
        ));
  }
}
