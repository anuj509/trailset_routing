import 'package:flutter/material.dart';

class NotchedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: NotchClipper(), // Custom clipper for the notch
              child: Container(
                width: 40.0, // Adjust the width of the notch
                height: 20.0, // Adjust the height of the notch
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final notchWidth = 40.0; // Adjust the width of the notch
    final notchHeight = 20.0; // Adjust the height of the notch

    path.lineTo((size.width - notchWidth) / 2, 0.0);
    path.lineTo(size.width / 2, -notchHeight);
    path.lineTo((size.width + notchWidth) / 2, 0.0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
