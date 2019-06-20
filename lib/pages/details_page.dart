import 'package:flutter/material.dart';
import 'package:flutter_app_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
import 'details_page/details_top_area.dart';
import 'details_page/details_explain.dart';
import 'details_page/details_tabbar.dart';
import 'details_page/details_web.dart';
import 'details_page/details_bottom.dart';
class DetailsPage extends StatelessWidget {
  //商品id
  final String goodsId;
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              //返回上一级
              Navigator.pop(context);
            }
        ),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context,snapShot){
          if(snapShot.hasData){
            //层叠组件
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      //商品详情头部
                      DetailsTopArea(),
                      //商品说明
                      DetailsExplain(),
                      //导航条
                      DetailsTabbar(),
                      DetailsWeb()
                    ],
                  ),
                ),
                //定位组件
                Positioned(bottom: 0, left: 0, child: DetailsBottom())
              ],
            );
          }else{
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );

  }

  Future _getBackInfo(BuildContext context) async{
    await Provide.value<DetailInfoProvider>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
