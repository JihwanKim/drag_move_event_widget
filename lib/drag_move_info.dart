import 'dart:math';
import 'dart:ui';

import 'drag_move_direction.dart';

class DragMoveInfo {
  final Offset startOffset;
  final Offset endOffset;

  double moveX = 0.0;
  double moveY = 0.0;
  double moveXY = 0.0;
  DragMoveDirection moveDirection = DragMoveDirection.NONE;

  final double _unitPoint = 30.0;

  DragMoveInfo(this.startOffset, this.endOffset) {
    final double startingX = startOffset.dx;
    final double startingY = startOffset.dy;
    final double endingX = endOffset.dx;
    final double endingY = endOffset.dy;
    moveX = startingX - endingX;
    moveY = startingY - endingY;
    moveXY = sqrt(pow(startingX - endingX, 2) + pow(startingY - endingY, 2));
    moveDirection = _getDirection();
  }

  DragMoveDirection _getDirection() {
    // move right
    if (moveX <= 0 && moveX.abs() > _unitPoint) {
      if (moveY.abs() <= _unitPoint) {
        return DragMoveDirection.RIGHT;
      } else {
        if (moveY >= 0) {
          return DragMoveDirection.DIAGONAL_RIGHT_UP;
        } else {
          return DragMoveDirection.DIAGONAL_RIGHT_DOWN;
        }
      }
    }
    // move left
    if (moveX >= 0 && moveX.abs() > _unitPoint) {
      if (moveY.abs() <= _unitPoint) {
        return DragMoveDirection.LEFT;
      } else {
        if (moveY >= 0) {
          return DragMoveDirection.DIAGONAL_LEFT_UP;
        } else {
          return DragMoveDirection.DIAGONAL_LEFT_DOWN;
        }
      }
    }
    // move up
    if (moveY >= 0 && moveY.abs() > _unitPoint) {
      if (moveX.abs() <= _unitPoint) {
        return DragMoveDirection.UP;
      } else {}
    }
    // move down
    if (moveY <= 0 && moveY.abs() > _unitPoint) {
      if (moveX.abs() <= _unitPoint) {
        return DragMoveDirection.DOWN;
      } else {}
    }
    return DragMoveDirection.NONE;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "offset ? start:$startOffset end:$endOffset // move ? x:$moveX y:$moveY xy:$moveXY  // direct:$moveDirection";
  }
}
