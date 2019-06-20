import 'package:flutter/material.dart';
class Counter with ChangeNotifier{
  int value = 0;
  increment(){
    value++;
    //局部刷新
    notifyListeners();
  }
}