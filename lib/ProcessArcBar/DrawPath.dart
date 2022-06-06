import 'dart:math';

import 'package:flutter/material.dart';

import '../services/percentSize.service.dart';



Path drawClipPath(Size size, Offset offset) {
  Path path = Path();
  double x = offset.dx + percentSize.cal(size, 24, Percent.width);
  double y = offset.dy + percentSize.cal(size, 0.5, Percent.height);
  path.moveTo(x, y);
  double startAngle = _calAngle(200);
  double sweepAngle = _calAngle(-42.2);
  double radius = percentSize.cal(size, 411, Percent.width);
  Offset center = Offset(
      offset.dx + radius,
      offset.dy + percentSize.cal(size, 47.5, Percent.height)
  );
  path.arcTo(
      Rect.fromCircle(center: center, radius: radius),
      startAngle, sweepAngle, false);

  x = offset.dx + percentSize.cal(size, 98, Percent.width);
  y = offset.dy + percentSize.cal(size, 99, Percent.height);
  path.lineTo(x, y);

  startAngle = _calAngle(157.8);
  sweepAngle = _calAngle(42.3);
  radius = percentSize.cal(size, 400, Percent.width);
  center = Offset(
      offset.dx + radius + percentSize.cal(size, 66, Percent.width),
      offset.dy + percentSize.cal(size, 46.5, Percent.height)
  );
  path.arcTo(
      Rect.fromCircle(center: center, radius: radius),
      startAngle, sweepAngle, false);

  path.close();
  return path;
}

double _calAngle(double angle) {
  return (angle * pi) / 180;
}