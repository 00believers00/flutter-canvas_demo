import 'package:flutter/material.dart';

double getResolution(BuildContext context){
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  double max = (width > height) ? width:height;
  double min = (width > height) ? height:width;
  return max/min;
}

ResolutionType getResolutionType(BuildContext context){
  double resolution = getResolution(context);
  ResolutionType resolutionType = ResolutionType.unknown;
  if(resolution < 2){
    resolutionType = ResolutionType.small;
  }else if(resolution < 2.5){
    resolutionType = ResolutionType.medium;
  }else if(resolution < 3.0){
    resolutionType = ResolutionType.large;
  }
  return resolutionType;
}


enum ResolutionType{
  unknown,
  small,
  medium,
  large
}