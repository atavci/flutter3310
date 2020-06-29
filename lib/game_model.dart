import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:nokiapro/snake/game_constants.dart';
import 'snake/apple.dart';
import 'snake/failure.dart';
import 'snake/point.dart';

import 'snake/board.dart';
import 'snake/snake_piece.dart';
import 'snake/splash.dart';
import 'snake/victory.dart';

class GameModel extends ChangeNotifier {
  var snakePiecePositions;
  Point applePosition;
  Timer timer;
  Direction _direction = Direction.UP;
  var gameState = GameState.SPLASH;

  void _grow() {
    snakePiecePositions.insert(0, _getHeadPosition());
    notifyListeners();
  }

  void _move() {
    snakePiecePositions.insert(0, _getHeadPosition());
    snakePiecePositions.removeLast();
    notifyListeners();
  }

  void _generateApple() {
    Random rng = Random();
    var min = 0;
    var max = BOARD_SIZE ~/ PIECE_SIZE;
    var nextX = min + rng.nextInt(max - min);
    var nextY = min + rng.nextInt(max - min);

    var Apple = Point(nextX.toDouble(), nextY.toDouble());

    if (snakePiecePositions.contains(Apple)) {
      _generateApple();
    } else {
      applePosition = Apple;
    }
    notifyListeners();
  }

  void changeDirection(Direction directionToGo) {
    switch (_direction) {
      case Direction.LEFT:
        if (directionToGo == Direction.UP) {
          _direction = Direction.UP;
          notifyListeners();
          return;
        }

        if (directionToGo == Direction.DOWN) {
          _direction = Direction.DOWN;
          notifyListeners();
          return;
        }
        break;

      case Direction.RIGHT:
        if (directionToGo == Direction.UP) {
          _direction = Direction.UP;
          notifyListeners();
          return;
        }

        if (directionToGo == Direction.DOWN) {
          _direction = Direction.DOWN;
          notifyListeners();
          return;
        }
        break;

      case Direction.UP:
        if (directionToGo == Direction.DOWN) {
          _direction = Direction.LEFT;
          notifyListeners();
          return;
        }

        if (directionToGo == Direction.UP) {
          _direction = Direction.RIGHT;
          notifyListeners();
          return;
        }
        break;

      case Direction.DOWN:
        if (directionToGo == Direction.DOWN) {
          _direction = Direction.LEFT;
          notifyListeners();
          return;
        }

        if (directionToGo == Direction.UP) {
          _direction = Direction.RIGHT;
          notifyListeners();
          return;
        }
        break;
    }
  }

  void changeGameState(GameState gameStateLocal) {
    gameState = gameStateLocal;
    notifyListeners();
  }

  void _generateFirstSnakePosition() {
    final midPoint = (BOARD_SIZE / PIECE_SIZE / 2);
    snakePiecePositions = [
      Point(midPoint, midPoint - 2),
      Point(midPoint, midPoint - 1),
      Point(midPoint, midPoint),
      Point(midPoint, midPoint + 1),
      Point(midPoint, midPoint + 2),
    ];
    notifyListeners();
  }

  Point _getHeadPosition() {
    var HeadPos;

    switch (_direction) {
      case Direction.LEFT:
        var currentHeadPos = snakePiecePositions.first;
        HeadPos = Point(currentHeadPos.x - 1, currentHeadPos.y);
        break;

      case Direction.RIGHT:
        var currentHeadPos = snakePiecePositions.first;
        HeadPos = Point(currentHeadPos.x + 1, currentHeadPos.y);
        break;

      case Direction.UP:
        var currentHeadPos = snakePiecePositions.first;
        HeadPos = Point(currentHeadPos.x, currentHeadPos.y - 1);
        break;

      case Direction.DOWN:
        var currentHeadPos = snakePiecePositions.first;
        HeadPos = Point(currentHeadPos.x, currentHeadPos.y + 1);
        break;
    }

    return HeadPos;
  }

  void handleTap(TapUpDetails tapUpDetails) {
    switch (gameState) {
      case GameState.SPLASH:
        moveFromSplashToRunningState();
        break;
      case GameState.RUNNING:
        // _changeDirectionBasedOnTap(tapUpDetails);
        print('Tapped while Running.');
        break;
      case GameState.VICTORY:
        changeGameState(GameState.SPLASH);
        break;
      case GameState.FAILURE:
        changeGameState(GameState.SPLASH);
        break;
    }
  }

  void moveFromSplashToRunningState() {
    _generateFirstSnakePosition();
    _generateApple();
    _direction = Direction.UP;
    changeGameState(GameState.RUNNING);
    timer = Timer.periodic(Duration(milliseconds: 500), _onTimerTick);
  }

  void _onTimerTick(Timer timer) {
    _move();

    if (_isWallCollision()) {
      changeGameState(GameState.FAILURE);
      return;
    }

    if (_isAppleCollision()) {
      if (_isBoardFilled()) {
        changeGameState(GameState.VICTORY);
      } else {
        _generateApple();
        _grow();
      }
      return;
    }
  }

  bool _isWallCollision() {
    var currentHeadPos = snakePiecePositions.first;

    if (currentHeadPos.x < 0 ||
        currentHeadPos.y < 0 ||
        currentHeadPos.x > BOARD_SIZE / PIECE_SIZE ||
        currentHeadPos.y > BOARD_SIZE / PIECE_SIZE) {
      return true;
    }

    return false;
  }

  bool _isAppleCollision() {
    if (snakePiecePositions.first.x == applePosition.x &&
        snakePiecePositions.first.y == applePosition.y) {
      return true;
    }

    return false;
  }

  bool _isBoardFilled() {
    final totalPiecesThatBoardCanFit =
        (BOARD_SIZE * BOARD_SIZE) / (PIECE_SIZE * PIECE_SIZE);
    if (snakePiecePositions.length == totalPiecesThatBoardCanFit) {
      return true;
    }

    return false;
  }

  Widget getBoardChildBasedOnGameState() {
    var child;

    switch (gameState) {
      case GameState.SPLASH:
        child = Splash();
        break;

      case GameState.RUNNING:
        List<Positioned> snakePiecesAndApple = List();
        snakePiecePositions.forEach((i) {
          snakePiecesAndApple.add(Positioned(
            child: SnakePiece(),
            left: i.x * PIECE_SIZE,
            top: i.y * PIECE_SIZE,
          ));
        });

        final apple = Positioned(
          child: Apple(),
          left: applePosition.x * PIECE_SIZE,
          top: applePosition.y * PIECE_SIZE,
        );

        snakePiecesAndApple.add(apple);

        child = Stack(children: snakePiecesAndApple);
        break;

      case GameState.VICTORY:
        timer.cancel();
        child = Victory();
        break;

      case GameState.FAILURE:
        timer.cancel();
        child = Failure();
        break;
    }

    return child;
  }
}
