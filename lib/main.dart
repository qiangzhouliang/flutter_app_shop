import 'package:flutter/material.dart';
import 'package:flutter_app_shop/pages/index_page.dart';
import 'package:flutter_app_shop/provide/current_index.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app_shop/provide/counter.dart';
import 'package:flutter_app_shop/provide/child_category.dart';
import 'package:flutter_app_shop/provide/category_goods_list.dart';
import 'package:flutter_app_shop/provide/details_info.dart';
import 'package:flutter_app_shop/provide/cart.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter_app_shop/router/application.dart';
import 'package:flutter_app_shop/router/routers.dart';
void main() {
  var providers = Providers();
  //注册状态管理依赖
  providers
    ..provide(Provider<Counter>.value(Counter()))
    ..provide(Provider<ChildCategory>.value(ChildCategory()))
    ..provide(Provider<CategoryGoodsListProvide>.value(CategoryGoodsListProvide()))
    ..provide(Provider<DetailInfoProvider>.value(DetailInfoProvider()))
    ..provide(Provider<CartProvide>.value(CartProvide()))
    ..provide(Provider<CurrentIndexProvide>.value(CurrentIndexProvide()));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //路由注册和静态化
    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        //添加路由
        onGenerateRoute: Application.router.generator,
        //取掉dubug
        debugShowCheckedModeBanner: false,
        //主题
        theme: ThemeData(
          //主颜色
          primaryColor: Colors.pink
        ),

        home: IndexPage(),
      ),
    );
  }
}
