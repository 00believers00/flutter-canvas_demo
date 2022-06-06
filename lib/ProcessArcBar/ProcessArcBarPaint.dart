import 'package:flutter/material.dart';

import '../services/percentSize.service.dart';
import 'DrawPath.dart';

class ProcessArcBarPaint extends CustomPainter{
  const ProcessArcBarPaint({
    this.left, this.top,
    this.widthCheck, this.heightCheck,
    required this.max, required this.value,
  });

  final double? left;
  final double? top;
  final double? widthCheck;
  final double? heightCheck;
  final int max;
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    if (left == null && top == null &&
        widthCheck == null &&  heightCheck == null) return;

    Size sizeC = Size(widthCheck!, heightCheck!);
    Offset offsetDraw = Offset(left!, top!);

    Path path = drawClipPath(sizeC, offsetDraw);
    //canvas.drawPath(path, Paint()..style=PaintingStyle.stroke..color = Colors.lightBlue);
    canvas.clipPath(path);

    path = Path();
    double per =  (100*value)/(max);
    double process = percentSize.cal(sizeC, per, Percent.height);
    double processUes = top!+(heightCheck!-process);
    Rect rect = Rect.fromLTWH(left!, processUes, widthCheck!, heightCheck!);
    path.addRect(rect);
    List<Color> colors = const [Color(0xff2484c6), Color(0x462484c6)];
    LinearGradient linearGradient =  LinearGradient(
      begin: Alignment.topRight,
      end:
      Alignment.bottomLeft,
      colors: colors, // red to yellow
      stops: const [
        0.2,
        1.0
      ],
      tileMode: TileMode.repeated, // repeats the gradient over the canvas
    );
    Paint paint = Paint()
      ..style=PaintingStyle.fill
      ..shader = linearGradient.createShader(rect);
    canvas.drawPath(path, paint);
    path = Path();
    rect = Rect.fromLTWH(left!, processUes, widthCheck!, 10);
    path.addRect(rect);
    paint = Paint()
      ..style=PaintingStyle.fill
      ..color= const Color(0xff021153);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}