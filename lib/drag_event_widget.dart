import 'package:flutter/material.dart';

import 'drag_move_direction.dart';
import 'drag_move_info.dart';

class DragEventWidget extends StatefulWidget {
  final Widget child;

  final Function onMoveLeft;
  final Function onMoveUp;
  final Function onMoveRight;
  final Function onMoveDown;

  // diagonal
  final Function onMoveDiagonalRightDown;
  final Function onMoveDiagonalRightUp;
  final Function onMoveDiagonalLeftDown;
  final Function onMoveDiagonalLeftUp;

  final double eventUnitPoint;

  final bool debug;

  const DragEventWidget(
      {Key key,
      @required this.child,
      this.onMoveLeft,
      this.onMoveUp,
      this.onMoveRight,
      this.onMoveDown,
      this.eventUnitPoint,
      this.onMoveDiagonalRightDown,
      this.onMoveDiagonalRightUp,
      this.onMoveDiagonalLeftDown,
      this.onMoveDiagonalLeftUp,
      this.debug = false})
      : super(key: key);

  @override
  _DragEventWidgetState createState() => _DragEventWidgetState();
}

class _DragEventWidgetState extends State<DragEventWidget> {
  Offset _dragStartingPoint;
  Offset _dragUpdatingPoint;

  @override
  Widget build(BuildContext context) {
    final double eventUnitPoint = widget.eventUnitPoint != null
        ? widget.eventUnitPoint
        : MediaQuery.of(context).size.width * 1 / 13;
    return GestureDetector(
        onHorizontalDragStart: (detail) {
          _dragStartingPoint = detail.globalPosition;
        },
        onHorizontalDragEnd: (detail) {
          if (_dragStartingPoint == null || _dragUpdatingPoint == null) {
            return;
          }
          final DragMoveInfo dragMoveInfo =
              DragMoveInfo(_dragStartingPoint, _dragUpdatingPoint);
          if (widget.debug) {
          }
          if (dragMoveInfo.moveDirection == DragMoveDirection.LEFT &&
              dragMoveInfo.moveX.abs() > eventUnitPoint) {
            if (widget.onMoveLeft != null) {
              widget.onMoveLeft();
            }
          } else if (dragMoveInfo.moveDirection == DragMoveDirection.UP &&
              dragMoveInfo.moveY.abs() > eventUnitPoint) {
            if (widget.onMoveUp != null) {
              widget.onMoveUp();
            }
          } else if (dragMoveInfo.moveDirection == DragMoveDirection.RIGHT &&
              dragMoveInfo.moveX.abs() > eventUnitPoint) {
            if (widget.onMoveRight != null) {
              widget.onMoveRight();
            }
          } else if (dragMoveInfo.moveDirection == DragMoveDirection.DOWN &&
              dragMoveInfo.moveY.abs() > eventUnitPoint) {
            if (widget.onMoveDown != null) {
              widget.onMoveDown();
            }
          } else if (dragMoveInfo.moveDirection ==
                  DragMoveDirection.DIAGONAL_RIGHT_DOWN &&
              dragMoveInfo.moveXY.abs() > eventUnitPoint) {
            if (widget.onMoveDiagonalRightDown != null) {
              widget.onMoveDiagonalRightDown();
            }
          } else if (dragMoveInfo.moveDirection ==
                  DragMoveDirection.DIAGONAL_RIGHT_UP &&
              dragMoveInfo.moveXY.abs() > eventUnitPoint) {
            if (widget.onMoveDiagonalRightUp != null) {
              widget.onMoveDiagonalRightUp();
            }
          } else if (dragMoveInfo.moveDirection ==
                  DragMoveDirection.DIAGONAL_LEFT_DOWN &&
              dragMoveInfo.moveXY.abs() > eventUnitPoint) {
            if (widget.onMoveDiagonalLeftDown != null) {
              widget.onMoveDiagonalLeftDown();
            }
          } else if (dragMoveInfo.moveDirection ==
                  DragMoveDirection.DIAGONAL_LEFT_UP &&
              dragMoveInfo.moveXY.abs() > eventUnitPoint) {
            if (widget.onMoveDiagonalLeftUp != null) {
              widget.onMoveDiagonalLeftUp();
            }
          } else {}
        },
        onHorizontalDragUpdate: (detail) {
          _dragUpdatingPoint = detail.globalPosition;
        },
        child: widget.child);
  }
}
