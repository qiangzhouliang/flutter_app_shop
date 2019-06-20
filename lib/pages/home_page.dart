import 'package:flutter/material.dart';
import 'package:flutter_app_shop/config/service_url.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_app_shop/router/application.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      //一个基于与Future交互的最新快照构建
      body:FutureBuilder(
        //获取数据的方法
        future: request('homePageContent',formData:{'lon':'115.02932','lat':'35.76189'}),
        //在请求时的操作
        builder: (BuildContext context,snapshot){
          if(snapshot.hasData){
            //数据处理处
            var data = json.decode(snapshot.data.toString());
            //轮播图
            List<Map> swiper = (data['data']['slides'] as List).cast();
            //头部导航栏
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            //广告条
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            //店长图片
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            //店长电话
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            //商品推荐
            List<Map> recommendList = (data['data']['recommend'] as List).cast();
            //楼层1标题
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            //楼层商品裂变
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            List<Map> floor3 = (data['data']['floor3'] as List).cast();
            //有上拉加载和下拉加载效果
            return EasyRefresh(
              //自定义foot
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                //加载时显示的文字
                moreInfo: '加载中...',
                //准备文字
                loadReadyText: '上拉加载更多',
              ),
              child:ListView(
                children: <Widget>[
                  //轮播图
                  SwiperDiy(swiperDataList: swiper),
                  //头部导航栏
                  TopNavigator(navigatorList),
                  //广告栏
                  AdBanner(adPicture),
                  //店长电话模块
                  LeaderPhone(leaderImage, leaderPhone),
                  //商品推荐模块
                  Recommend(recommendList),
                  //楼层1标题
                  FloorTitle(floor1Title),
                  //楼层商品列表
                  FloorContent(floor1),
                  //楼层2标题
                  FloorTitle(floor2Title),
                  //楼层商品列表
                  FloorContent(floor2),
                  //楼层3标题
                  FloorTitle(floor3Title),
                  //楼层商品列表
                  FloorContent(floor3),
                  //火爆专区
                  _hotGoods(),
                ],
              ),
              //加载更多
              loadMore: () async{
                print('开始加载更多');
                _getHotGoods();
              },
            );
          }else{
            //正在加载过程中展示的内容
            return Center(
              child: Text('加载中。。。'),
            );
          }
        },
      ),
    );
  }

  void _getHotGoods(){
    var formPage = {'page':page};
    request('homePageBelowConten',formData: formPage).then((val){
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  //火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    //透明背景色
    color: Colors.transparent,
    padding: EdgeInsets.all(5.0),
    child: Text('火爆专区'),
  );


  Widget _wrapList(){
    if(hotGoodsList.length != 0){
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
          onTap: (){
            Application.router.navigateTo(context, '/detail?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'],width: ScreenUtil().setWidth(370),),
                Text(val['name'],maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink,fontSize:ScreenUtil().setSp(26) ),),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text('￥${val['price']}',
                      style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough,),),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();
      //流式布局
      return Wrap(
        //2列
        spacing: 2,
        children: listWidget,
      );
    }else{
      return Text('');
    }
  }

  //火爆专区商品
  Widget _hotGoods(){
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList()
        ],
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
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          //填充 满容器填充
          return InkWell(
            onTap: (){
              //页面跳转
              Application.router.navigateTo(context, '/detail?id=${swiperDataList[index]['goodsId']}');
            },
            child: Image.network(swiperDataList[index]['image'],fit: BoxFit.fill,),
          );
        },

        itemCount: swiperDataList.length,
        //导航器-小点
        pagination: SwiperPagination(),
      ),
    );
  }
}

//顶部导航区
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator(this.navigatorList);

  Widget _gridViewItemUI(BuildContext context,item){
    return InkWell(
      onTap: (){
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width: ScreenUtil().setWidth(95),),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(this.navigatorList.length > 10){
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: const EdgeInsets.all(3.0),
      child: GridView.count(
        //禁止滚动
        physics: NeverScrollableScrollPhysics(),
        //一行有5个
        crossAxisCount: 5,
        padding: const EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//banner 广告轮播条
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner(this.adPicture);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage;//店长图片
  final String leaderPhone;//店长电话

  LeaderPhone(this.leaderImage, this.leaderPhone);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _LaunchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _LaunchURL() async{
    String url = 'tel:'+leaderPhone;
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'url不能进行访问，异常';
    }
  }
}

//商品推荐模块
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend(this.recommendList);
  //标题方法
  Widget _titleWidget(){
    return Container(
      //对齐方式
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12)
        )
      ),
      child: Text('商品推荐',style: TextStyle(color: Colors.pink),),
    );
  }

  //商品单独项方法
  Widget _item(BuildContext context,index){
    return InkWell(
      onTap: (){
        //页面跳转
        Application.router.navigateTo(context, '/detail?id=${recommendList[index]['goodsId']}');
      },
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1,color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
                '￥${recommendList[index]['price']}',
              style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  //横向列表方法
  Widget _recommedList(){
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index){
          return _item(context,index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(390),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),_recommedList()
        ],
      ),
    );
  }
}

//楼层标题
class FloorTitle extends StatelessWidget {
  final String picture_address;

  FloorTitle(this.picture_address);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent(this.floorGoodsList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context)
        ],
      ),
    );
  }

  Widget _firstRow(BuildContext context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context,floorGoodsList[1]),
            _goodsItem(context,floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(BuildContext context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[3]),
        _goodsItem(context,floorGoodsList[4]),
      ],
    );
  }
  Widget _goodsItem(BuildContext context, Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){
          //页面跳转
          Application.router.navigateTo(context, '/detail?id=${goods['goodsId']}');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}











