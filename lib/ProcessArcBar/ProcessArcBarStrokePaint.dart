import 'package:flutter/material.dart';
import 'DrawPath.dart';

class ProcessArcBarStrokePaint extends CustomPainter{
  const ProcessArcBarStrokePaint({this.left, this.top, this.widthCheck, this.heightCheck});

  final double? left;
  final double? top;
  final double? widthCheck;
  final double? heightCheck;

  @override
  void paint(Canvas canvas, Size size) {
    if (left == null && top == null &&
        widthCheck == null &&  heightCheck == null) return;

    Size sizeC = Size(widthCheck!, heightCheck!);
    Offset offsetDraw = Offset(left!, top!);

    Path path = drawClipPath(sizeC, offsetDraw);
    canvas.drawPath(path,
        Paint()..style=
            PaintingStyle.stroke
          ..color = Colors.grey.withOpacity(0.8)
          ..strokeWidth=1);
  }



  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}