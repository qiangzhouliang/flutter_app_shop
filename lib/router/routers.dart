import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';
class Routers {
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRouters(Router router){
    //找不到handle时的配置
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('ERROR ===> Router was not found!!!');
      }
    );
    //配置路由
    router.define(detailsPage, handler: detailsHandler);
  }
}