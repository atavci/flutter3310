import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nokiapro/styles/app_colors.dart';
import './apple.dart';
import './failure.dart';
import './game_constants.dart';
import './snake_piece.dart';
import './point.dart';
import './splash.dart';
import './victory.dart';

class Board extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardState();
}

enum Direction { LEFT, RIGHT, UP, DOWN }
enum GameState { SPLASH, RUNNING, VICTORY, FAILURE }

class _BoardState extends State<Board> {
  var _snakePiecePositions;
  Point _applePosition;
  Timer _timer;
  Direction _direction = Direction.UP;
  var _gameState = GameState.SPLASH;

  @override
  void initState() {
    _moveFromSplashToRunningState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.greenScreenColor,
        width: BOARD_SIZE,
        height: BOARD_SIZE,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (tapUpDetails) {
            _handleTap(tapUpDetails);
          },
          child: _getBoardChildBasedOnGameState(),
        ));
  }

  Widget _getBoardChildBasedOnGameState() {
    var child;

    switch (_gameState) {
      case GameState.SPLASH:
        child = Splash();
        break;

      case GameState.RUNNING:
        List<Positioned> snakePiecesAndApple = List();
        _snakePiecePositions.forEach((i) {
          snakePiecesAndApple.add(Positioned(
            child: SnakePiece(),
            left: i.x * PIECE_SIZE,
            top: i.y * PIECE_SIZE,
          ));
        });

        final apple = Positioned(
          child: Apple(),
          left: _applePosition.x * PIECE_SIZE,
          top: _applePosition.y * PIECE_SIZE,
        );

        snakePiecesAndApple.add(apple);

        child = Stack(children: snakePiecesAndApple);
        break;

      case GameState.VICTORY:
        _timer.cancel();
        child = Victory();
        break;

      case GameState.FAILURE:
        _timer.cancel();
        child = Failure();
        break;
    }

    return child;
  }

  void _onTimerTick(Timer timer) {
    _move();

    if (_isWallCollision()) {
      _changeGameState(GameState.FAILURE);
      return;
    }

    if (_isAppleCollision()) {
      if (_isBoardFilled()) {
        _changeGameState(GameState.VICTORY);
      } else {
        _generateApple();
        _grow();
      }
      return;
    }
  }

  void _grow() {
    setState(() {
      _snakePiecePositions.insert(0, _getHeadPosition());
    });
  }

  void _move() {
    setState(() {
      _snakePiecePositions.insert(0, _getHeadPosition());
      _snakePiecePositions.removeLast();
    });
  }

  bool _isWallCollision() {
    var currentHeadPos = _snakePiecePositions.first;

    if (currentHeadPos.x < 0 ||
        currentHeadPos.y < 0 ||
        currentHeadPos.x > BOARD_SIZE / PIECE_SIZE ||
        currentHeadPos.y > BOARD_SIZE / PIECE_SIZE) {
      return true;
    }

    return false;
  }

  bool _isAppleCollision() {
    if (_snakePiecePositions.first.x == _applePosition.x &&
        _snakePiecePositions.first.y == _applePosition.y) {
      return true;
    }

    return false;
  }

  bool _isBoardFilled() {
    final totalPiecesThatBoardCanFit =
        (BOARD_SIZE * BOARD_SIZE) / (PIECE_SIZE * PIECE_SIZE);
    if (_snakePiecePositions.length == totalPiecesThatBoardCanFit) {
      return true;
    }

    return false;
  }

  Point _getHeadPosition() {
    var HeadPos;

    switch (_direction) {
      case Direction.LEFT:
        var currentHeadPos = _snakePiecePositions.first;
        HeadPos = Point(currentHeadPos.x - 1, currentHeadPos.y);
        break;

      case Direction.RIGHT:
        var currentHeadPos = _snakePiecePositions.first;
        HeadPos = Point(currentHeadPos.x + 1, currentHeadPos.y);
        break;

      case Direction.UP:
        var currentHeadPos = _snakePiecePositions.first;
        HeadPos = Point(currentHeadPos.x, currentHeadPos.y - 1);
        break;

      case Direction.DOWN:
        var currentHeadPos = _snakePiecePositions.first;
        HeadPos = Point(currentHeadPos.x, currentHeadPos.y + 1);
        break;
    }

    return HeadPos;
  }

  void _handleTap(TapUpDetails tapUpDetails) {
    switch (_gameState) {
      case GameState.SPLASH:
        _moveFromSplashToRunningState();
        break;
      case GameState.RUNNING:
        _changeDirectionBasedOnTap(tapUpDetails);
        break;
      case GameState.VICTORY:
        _changeGameState(GameState.SPLASH);
        break;
      case GameState.FAILURE:
        _changeGameState(GameState.SPLASH);
        break;
    }
  }

  void _moveFromSplashToRunningState() {
    _generateFirstSnakePosition();
    _generateApple();
    _direction = Direction.UP;
    _changeGameState(GameState.RUNNING);
    _timer = Timer.periodic(Duration(milliseconds: 500), _onTimerTick);
  }

  void _changeDirectionBasedOnTap(TapUpDetails tapUpDetails) {
    RenderBox getBox = context.findRenderObject();
    var localPosition = getBox.globalToLocal(tapUpDetails.globalPosition);
    final x = (localPosition.dx / PIECE_SIZE).round();
    final y = (localPosition.dy / PIECE_SIZE).round();

    final currentHeadPos = _snakePiecePositions.first;

    switch (_direction) {
      case Direction.LEFT:
        if (y < currentHeadPos.y) {
          setState(() {
            _direction = Direction.UP;
          });
          return;
        }

        if (y > currentHeadPos.y) {
          setState(() {
            _direction = Direction.DOWN;
          });
          return;
        }
        break;

      case Direction.RIGHT:
        if (y < currentHeadPos.y) {
          setState(() {
            _direction = Direction.UP;
          });
          return;
        }

        if (y > currentHeadPos.y) {
          setState(() {
            _direction = Direction.DOWN;
          });
          return;
        }
        break;

      case Direction.UP:
        if (x < currentHeadPos.x) {
          setState(() {
            _direction = Direction.LEFT;
          });
          return;
        }

        if (x > currentHeadPos.x) {
          setState(() {
            _direction = Direction.RIGHT;
          });
          return;
        }
        break;

      case Direction.DOWN:
        if (x < currentHeadPos.x) {
          setState(() {
            _direction = Direction.LEFT;
          });
          return;
        }

        if (x > currentHeadPos.x) {
          setState(() {
            _direction = Direction.RIGHT;
          });
          return;
        }
        break;
    }
  }

  void _changeDirection(Direction directionToGo) {
    switch (_direction) {
      case Direction.LEFT:
        if (directionToGo == Direction.UP) {
          setState(() {
            _direction = Direction.UP;
          });
          return;
        }

        if (directionToGo == Direction.DOWN) {
          setState(() {
            _direction = Direction.DOWN;
          });
          return;
        }
        break;

      case Direction.RIGHT:
        if (directionToGo == Direction.UP) {
          setState(() {
            _direction = Direction.UP;
          });
          return;
        }

        if (directionToGo == Direction.UP) {
          setState(() {
            _direction = Direction.DOWN;
          });
          return;
        }
        break;

      case Direction.UP:
        if (directionToGo == Direction.DOWN) {
          setState(() {
            _direction = Direction.LEFT;
          });
          return;
        }

        if (directionToGo == Direction.UP) {
          setState(() {
            _direction = Direction.RIGHT;
          });
          return;
        }
        break;

      case Direction.DOWN:
        if (directionToGo == Direction.DOWN) {
          setState(() {
            _direction = Direction.LEFT;
          });
          return;
        }

        if (directionToGo == Direction.UP) {
          setState(() {
            _direction = Direction.RIGHT;
          });
          return;
        }
        break;
    }
  }

  void _changeGameState(GameState gameState) {
    setState(() {
      _gameState = gameState;
    });
  }

  void _generateFirstSnakePosition() {
    setState(() {
      final midPoint = (BOARD_SIZE / PIECE_SIZE / 2);
      _snakePiecePositions = [
        Point(midPoint, midPoint - 2),
        Point(midPoint, midPoint - 1),
        Point(midPoint, midPoint),
        Point(midPoint, midPoint + 1),
        Point(midPoint, midPoint + 2),
      ];
    });
  }

  void _generateApple() {
    setState(() {
      Random rng = Random();
      var min = 0;
      var max = BOARD_SIZE ~/ PIECE_SIZE;
      var nextX = min + rng.nextInt(max - min);
      var nextY = min + rng.nextInt(max - min);

      var Apple = Point(nextX.toDouble(), nextY.toDouble());

      if (_snakePiecePositions.contains(Apple)) {
        _generateApple();
      } else {
        _applePosition = Apple;
      }
    });
  }
}
