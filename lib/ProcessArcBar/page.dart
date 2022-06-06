import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/percentSize.service.dart';
import '../services/resolution.service.dart';
import 'ProcessArcBarPaint.dart';
import 'ProcessArcBarStrokePaint.dart';

class ProcessArcBar extends StatefulWidget {
  const ProcessArcBar({Key? key,
    required this.title,
    required this.width, required this.height,
    required this.value, required this.max, this.flip = false, this.unit="",
    required this.widthRefImageBg, required this.heightRefImageBg,
  }) : super(key: key);


  final int widthRefImageBg;
  final int heightRefImageBg;
  final double width;
  final double height;
  final double value;
  final int max;
  final bool flip;
  final String title;
  final String unit;

  @override
  State<ProcessArcBar> createState() => _ProcessArcBarState();
}

class _ProcessArcBarState extends State<ProcessArcBar> {
  double value = 0;
  double valueOld = 0;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
    _stopTimerLoopSmoothData();
  }

  @override
  Widget build(BuildContext context) {
    if(left == null || top == null ||  widthCheck == null ||  heightCheck == null){
      return Container();
    }
    if(value != widget.value){
      if(widget.value <= 0){
        value = 0;
      } else if(widget.value >= widget.max){
        value = widget.max.roundToDouble();
      }else {
        value = widget.value;
      }
      _startTimerLoopSmoothData();
    }
    EdgeInsets edgeInsets = (getResolutionType(context) == ResolutionType.small) ?
    EdgeInsets.only(left:10.w):const EdgeInsets.all(0);
    return Transform(
      alignment: Alignment.center,
      transform: (widget.flip) ? Matrix4.rotationY(pi):Matrix4.rotationY(0),
      child: SizedBox(
        width: widget.width, height: widget.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: edgeInsets,
              child: CustomPaint(
                painter: ProcessArcBarPaint(
                    left: left, top: top,
                    widthCheck: widthCheck, heightCheck: heightCheck,
                  value: valueOld, max: widget.max,
                ),
              ),
            ),
            Padding(
              padding: edgeInsets,
              child: CustomPaint(
                painter: ProcessArcBarStrokePaint(
                    left: left, top: top,
                    widthCheck: widthCheck, heightCheck: heightCheck
                ),
              ),
            ),
            Transform(
              alignment: Alignment.center,
              transform: (widget.flip) ? Matrix4.rotationY(pi):Matrix4.rotationY(0),
              origin: (widget.flip) ?
              (getResolutionType(context) == ResolutionType.small) ? Offset(-165.w,0):Offset(-50.w,0):null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme.subtitle1?.apply(
                        color: Colors.black,
                        //fontFamily: R.font.superMotherPlain
                    ),
                  ),
                  Text(
                    "${value.toStringAsFixed(0)} ${widget.unit}",
                    style: Theme.of(context)
                        .textTheme.subtitle1?.apply(
                        color: Colors.black,
                        //fontFamily: R.font.superMotherPlain
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double? left;
  double? top;
  double? widthCheck;
  double? heightCheck;
  void _initData(){
    PercentSize percent = PercentSize();
    int widthImage = widget.widthRefImageBg;
    int heightImage = widget.heightRefImageBg;
    double ratio = widthImage / heightImage;
    double widthSize = widget.width;
    double heightSize = widget.height;
    Size size = Size(widthSize, heightSize);
    widthCheck = heightSize * ratio;
    heightCheck = heightSize;
    bool check = true;
    double countSize = 100;
    while (check) {
      if (widthCheck! <= widthSize) {
        check = false;
      } else {
        countSize--;
        heightCheck = percent.cal(size, countSize, Percent.height);
        widthCheck = heightCheck! * ratio;
      }
    }
    left = (widthSize - widthCheck!) / 2;
    top = (heightSize - heightCheck!) / 2;
    setState(() {});
  }

  Timer? _timerLoopSmoothData;

  void _startTimerLoopSmoothData() {
    _stopTimerLoopSmoothData();
    if (_timerLoopSmoothData == null) {
      int i = 0;
      //angleShowScaleRpm = 0;
      _timerLoopSmoothData =
          Timer.periodic(const Duration(milliseconds: 20), (t) {
            i++;
            valueOld += ((value - valueOld) * 0.1);//0.03 , 0.3

            if (i == 400) {
              _stopTimerLoopSmoothData();
            }
            setState(() {});
          });
    }
  }

  void _stopTimerLoopSmoothData() {
    if (_timerLoopSmoothData != null) {
      _timerLoopSmoothData!.cancel();
      _timerLoopSmoothData = null;
    }
  }

}//end class
