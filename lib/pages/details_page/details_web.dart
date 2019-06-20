import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app_shop/provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<DetailInfoProvider>(context).goodsInfo.data.goodInfo.goodsDetail;
    return Provide<DetailInfoProvider>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailInfoProvider>(context).isLeft;
        if(isLeft){
          return Container(
            child: Html(data: goodsDetails),
          );
        }else{
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }
}
