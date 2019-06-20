import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app_shop/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//商品详情页的首屏区域，包括图片、商品名称，商品价格，商品编号的UI展示
class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailInfoProvider>(
      builder: (context,child,val){
        var goodsInfo = Provide.value<DetailInfoProvider>(context).goodsInfo.data.goodInfo;
        if(goodsInfo != null){
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice)
              ],
            ),
          );
        }else{
          return Text('正在加载中。。。');
        }
      },
    );
  }
  //商品图片
  Widget _goodsImage(url){
    return Image.network(url,width: ScreenUtil().setWidth(740),);
  }
  //商品名称
  Widget _goodsName(name){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(name,style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
    );
  }
  //商品编号
  Widget _goodsNum(num){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text('编号：${num}',style: TextStyle(color: Colors.black12),),
    );
  }
  //商品价格方法
  Widget _goodsPrice(presentPrice,oriPrice){
    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Row(
        children: <Widget>[
          Text('￥${presentPrice}', style: TextStyle(color:Colors.pinkAccent, fontSize: ScreenUtil().setSp(40),),),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text('市场价:￥${oriPrice}', style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),),
          ),
        ],
      ),
    );

  }
}
