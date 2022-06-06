import 'package:flutter/material.dart';

final PercentSize percentSize = PercentSize();
class PercentSize{

  double cal(Size size,double per,Percent type){
    if(type == Percent.width){
      //var data = ((size.width * per)/100);
      return ((size.width * per)/100);
      //return ServiceCode.sizeArea(mContext, data);
    }

    if(type == Percent.height){
      //var data = ((size.height * per)/100);
      return ((size.height * per)/100);
      //return ServiceCode.sizeArea(mContext, data);
    }
    return 0;
  }
}
enum Percent{
  width,
  height
}