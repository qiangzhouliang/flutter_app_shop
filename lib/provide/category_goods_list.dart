import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';
//分类商品列表状态控制类
class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryListData> goodsList = [];
  //点击大类时，更换商品列表
  getGoodsList(List<CategoryListData> list){
    goodsList = list;
    notifyListeners();
  }
  //点击大类时，更换商品列表
  getMoreList(List<CategoryListData> list){
    goodsList.addAll(list);
    notifyListeners();
  }
}