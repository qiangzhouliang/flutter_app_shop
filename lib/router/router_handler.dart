import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_app_shop/pages/details_page.dart';

//操作器
Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String goodsId = params['id'].first;
    print('index>details goodsId is ${goodsId}');
    //需要返回的页面组件
    return DetailsPage(goodsId);
  }
);