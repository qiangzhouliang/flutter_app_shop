import 'package:flutter/material.dart';
import 'package:flutter_app_shop/model/details_model.dart';
import 'package:flutter_app_shop/service/service_method.dart';
import 'dart:convert';
//商品详情数据请求
class DetailInfoProvider with ChangeNotifier{
  DetailsModel goodsInfo;
  bool isLeft = true;
  bool isRight = false;

  //tabbar切换方法
  changeLeftAndRight(String changeState){
    if(changeState == 'left'){
      isLeft = true;
      isRight = false;
    }else{
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
  //从后台获取商品数据
  getGoodsInfo(String id) async{
    var formData = {'goodId':id};
    await request('getGoodDetailById',formData: formData).then((val){
      var data = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(data);
      notifyListeners();
    });
  }
}
