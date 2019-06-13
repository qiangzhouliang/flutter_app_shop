import 'package:flutter/material.dart';
import 'package:flutter_app_shop/pages/home_page.dart';
import 'package:flutter_app_shop/pages/index_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
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
