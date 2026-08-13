import 'package:flutter/material.dart';

extension AppSize on BuildContext {
  double get altura => MediaQuery.of(this).size.height;
  double get largura => MediaQuery.of(this).size.width;
}
