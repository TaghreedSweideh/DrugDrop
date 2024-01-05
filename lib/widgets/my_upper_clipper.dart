import 'package:flutter/material.dart';

class MyUpperClipper extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height * 0.4);
    path.cubicTo(width * 1 / 2, height * 1 / 9, width * 2 / 4, height * 1.0, width, height * 0.6);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;

}