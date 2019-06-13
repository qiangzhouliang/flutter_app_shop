import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  //底部tabbar内容
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),title: Text('分类')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart),title: Text('购物车')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled),title: Text('会员中心'))
  ];

  //页面数组
  final List tabBodies = [HomePage(),CategoryPage(),CartPage(),MemberPage()];

  int currentIndex = 0;
  var currentPage;
  @override
  void initState() {
    super.initState();
    //设置默认页
    currentPage = tabBodies[currentIndex];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //默认背景颜色
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      //底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        //类型
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        //单击事件
        onTap: (index){
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),

      //内容
      body: currentPage,
    );
  }
}

