import 'package:flutter/material.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = 5.0;

    path.moveTo(0, 0);
    path.lineTo(size.width - radius, size.height / 2);
    path.quadraticBezierTo(size.width, size.height / 2, size.width - radius,
        size.height / 2 + radius);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
