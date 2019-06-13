import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';
  @override
  void initState() {
    super.initState();
    getHomePageContent().then((val){
      setState(() {
        homePageContent = val.toString();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body:FutureBuilder(
        future: getHomePageContent(),
        //在请求时的操作
        builder: (BuildContext context,snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiper)
              ],
            );
          }else{
            return Center(
              child: Text('加载中。。。'),
            );
          }
        },
      ),
    );
  }
}
//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network(swiperDataList[index]['image']);
        },

        itemCount: swiperDataList.length,
        //导航器-小点
        pagination: SwiperPagination(),
      ),
    );
  }
}



