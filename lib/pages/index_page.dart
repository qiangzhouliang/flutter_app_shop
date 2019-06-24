import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app_shop/provide/current_index.dart';
import 'movie_page.dart';

class IndexPage extends StatelessWidget {
  //底部tabbar内容
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),title: Text('分类')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart),title: Text('购物车')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled),title: Text('会员中心')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.video_camera_solid),title: Text('视频'))
  ];

  //页面数组
  final List<Widget> tabBodies = [HomePage(),CategoryPage(),CartPage(),MemberPage(),MoviePage()];

  @override
  Widget build(BuildContext context) {
    //设置尺寸
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Provide<CurrentIndexProvide>(
      builder: (context,child,val){
        int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;
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
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },
          ),
          //内容
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        );
      },
    );
  }
}
