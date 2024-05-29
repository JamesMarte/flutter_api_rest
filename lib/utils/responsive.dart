
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {

  double _width =0;
  double _heigth = 0;
  double _diagonal = 0;
  bool _isTablet = false;

 
  double get width => _width;
  double get heigth => _heigth;
  double get diagonal => _diagonal;
  bool get isTablet => _isTablet;
  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
   final Size  size = MediaQuery.of(context).size;
   this._width= size.width;
   this._heigth= size.height;

   //c2 + a2 + b2 = 
   this._diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_heigth, 2));

   this._isTablet =size.shortestSide >= 600;
  }

double wp(double percent) => _width * percent /100;
double hp(double percent) => _heigth *percent /100;
double dp(double percent) => _diagonal *percent /100;

}