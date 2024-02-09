library popup_shape;

import 'package:flutter/material.dart';

part 'shape_painter.dart';

enum PopupArrowPosition {
  bottomLeft,
  bottomCenter,
  bottomRight,
  centerRight,
  centerLeft,
  topLeft,
  topCenter,
  topRight,
  none
}

class PopupShapes extends StatelessWidget {
  final Color bgColor;
  final Color shadowColor;
  final double shadowRadius;
  final PopupArrowPosition position;
  final Widget child;
  final double width;
  final double height;

  PopupShapes({
    super.key,
    this.bgColor = Colors.blue,
    this.shadowColor = Colors.grey,
    this.shadowRadius = 3.0,
    this.position = PopupArrowPosition.bottomCenter,
    this.child = const SizedBox(),
    this.width = 55,
    this.height = 55,
  }) {
    assert(height > 45);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: CustomPaint(
        painter: ShapePainter(
          bgColor: bgColor,
          shadowColor: shadowColor,
          shadowRadius: shadowRadius,
          position: position,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: child,
        ),
      ),
    );
  }
}
