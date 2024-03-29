part of popup_shape;

class ShapePainter extends CustomPainter {
  final Color bgColor;
  final Color shadowColor;
  final double shadowRadius;
  final PopupArrowPosition position;

  const ShapePainter(
      {required this.bgColor,
      required this.shadowColor,
      this.shadowRadius = 4,
      required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    Path path;
    switch (position) {
      case PopupArrowPosition.bottomCenter:
        path = bottomCenter(width, height);
        break;
      case PopupArrowPosition.bottomLeft:
        path = bottomLeft(width, height);
        break;
      case PopupArrowPosition.bottomRight:
        path = bottomRight(width, height);
        break;
      case PopupArrowPosition.centerRight:
        path = centerRight(width, height);
        break;
      case PopupArrowPosition.centerLeft:
        path = centerLeft(width, height);
        break;
      case PopupArrowPosition.topRight:
        path = topRight(width, height);
        break;
      case PopupArrowPosition.topLeft:
        path = topLeft(width, height);
        break;
      case PopupArrowPosition.topCenter:
        path = topCenter(width, height);
        break;
      case PopupArrowPosition.none:
        path = none(width, height);
        break;
      default:
        path = bottomCenter(width, height);
        break;
    }
    Paint paint = Paint();
    paint.color = bgColor;
    canvas.drawShadow(path, shadowColor, 20, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Path topCenter(double width, double height) {
  Path path = Path();
  path.moveTo(10, 10);
  path.lineTo(width / 2 - 10, 10);
  path.lineTo(width / 2 - 2, 2);
  path.quadraticBezierTo(width / 2, 0, width / 2 + 2, 2);
  path.lineTo(width / 2 + 10, 10);
  path.lineTo(width - 10, 10);
  path.quadraticBezierTo(width, 10, width, 20);
  path.lineTo(width, height - 20);
  path.quadraticBezierTo(width, height, width - 10, height);
  path.lineTo(10, height);
  path.quadraticBezierTo(0, height, 0, height - 10);
  path.lineTo(0, 20);
  path.quadraticBezierTo(0, 10, 10, 10);
  path.close();
  return path;
}

Path topLeft(double width, double height) {
  Path path = Path();
  path.moveTo(10, 10);
  path.lineTo(40, 10);
  path.lineTo(32, 2);
  path.quadraticBezierTo(30, 0, 28, 2);
  path.lineTo(20, 10);
  path.lineTo(width - 10, 10);
  path.quadraticBezierTo(width, 10, width, 20);
  path.lineTo(width, height - 20);
  path.quadraticBezierTo(width, height, width - 10, height);
  path.lineTo(10, height);
  path.quadraticBezierTo(0, height, 0, height - 10);
  path.lineTo(0, 20);
  path.quadraticBezierTo(0, 10, 10, 10);
  path.close();
  return path;
}

Path topRight(double width, double height) {
  Path path = Path();
  path.moveTo(10, 10);
  path.lineTo(width - 40, 10);
  path.lineTo(width - 32, 2);
  path.quadraticBezierTo(width - 30, 0, width - 28, 2);
  path.lineTo(width - 20, 10);
  path.lineTo(width - 10, 10);
  path.quadraticBezierTo(width, 10, width, 20);
  path.lineTo(width, height - 20);
  path.quadraticBezierTo(width, height, width - 10, height);
  path.lineTo(10, height);
  path.quadraticBezierTo(0, height, 0, height - 10);
  path.lineTo(0, 20);
  path.quadraticBezierTo(0, 10, 10, 10);
  path.close();
  return path;
}

Path centerLeft(double width, double height) {
  Path path = Path();
  path.moveTo(20, 0);
  path.lineTo(width - 10, 0);
  path.quadraticBezierTo(width, 0, width, 10);
  path.lineTo(width, height - 10);
  path.quadraticBezierTo(width, height, width - 10, height);
  path.lineTo(20, height);
  path.quadraticBezierTo(10, height, 10, height - 10);
  path.lineTo(10, height / 2 + 10);
  path.lineTo(2, height / 2 + 2);
  path.quadraticBezierTo(0, height / 2, 2, height / 2 - 2);
  path.lineTo(10, height / 2 - 10);
  path.lineTo(10, 10);
  path.quadraticBezierTo(10, 0, 20, 0);
  path.close();
  return path;
}

Path centerRight(double width, double height) {
  Path path = Path();
  path.moveTo(10, 0);
  path.lineTo(width - 20, 0);
  path.quadraticBezierTo(width - 10, 0, width - 10, 10);
  path.lineTo(width - 10, height / 2 - 10);
  path.lineTo(width - 2, height / 2 - 2);
  path.quadraticBezierTo(width, height / 2, width - 2, height / 2 + 2);
  path.lineTo(width - 10, height / 2 + 10);
  path.lineTo(width - 10, height - 10);
  path.quadraticBezierTo(width - 10, height, width - 20, height);
  path.lineTo(10, height);
  path.quadraticBezierTo(0, height, 0, height - 10);
  path.lineTo(0, 10);
  path.quadraticBezierTo(0, 0, 10, 0);
  path.close();
  return path;
}

Path bottomRight(double width, double height) {
  Path path = Path();
  path.moveTo(10, 0);
  path.lineTo(width - 10, 0);
  path.quadraticBezierTo(width, 0, width, 10);
  path.lineTo(width, height - 20);
  path.quadraticBezierTo(width, height - 10, width, height - 10);
  path.lineTo(width, height - 10);
  path.lineTo(width, height - 5);
  path.quadraticBezierTo(width, height + 2, width, height + 2);
  path.lineTo(width - 20, height - 10);
  path.lineTo(10, height - 10);
  path.quadraticBezierTo(0, height - 10, 0, height - 20);
  path.lineTo(0, 10);
  path.quadraticBezierTo(0, 0, 10, 0);
  path.close();
  return path;
}

Path bottomLeft(double width, double height) {
  Path path = Path();
  path.moveTo(10, 0);
  path.lineTo(width - 10, 0);
  path.quadraticBezierTo(width, 0, width, 10);
  path.lineTo(width, height - 20);
  path.quadraticBezierTo(width, height - 10, width - 10, height - 10);
  path.lineTo(40, height - 10);
  path.lineTo(32, height - 2);
  path.quadraticBezierTo(30, height, 28, height - 2);
  path.lineTo(20, height - 10);
  path.lineTo(10, height - 10);
  path.quadraticBezierTo(0, height - 10, 0, height - 20);
  path.lineTo(0, 10);
  path.quadraticBezierTo(0, 0, 10, 0);
  path.close();
  return path;
}

Path bottomCenter(double width, double height) {
  Path path = Path();
  path.moveTo(10, 0);
  path.lineTo(width - 10, 0);
  path.quadraticBezierTo(width, 0, width, 10);
  path.lineTo(width, height - 20);
  path.quadraticBezierTo(width, height - 10, width - 10, height - 10);
  path.lineTo(width / 2 + 10, height - 10);
  path.lineTo(width / 2 + 2, height - 2);
  path.quadraticBezierTo(width / 2, height, width / 2 - 2, height - 2);
  path.lineTo(width / 2 - 10, height - 10);
  path.lineTo(10, height - 10);
  path.quadraticBezierTo(0, height - 10, 0, height - 20);
  path.lineTo(0, 10);
  path.quadraticBezierTo(0, 0, 10, 0);
  path.close();

  return path;
}

Path none(double width, double height) {
  Path path = Path();
  path.close();
  return path;
}
