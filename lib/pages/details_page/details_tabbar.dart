import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app_shop/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailInfoProvider>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailInfoProvider>(context).isLeft;
        var isRight = Provide.value<DetailInfoProvider>(context).isRight;
        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Row(
            children: <Widget>[
              _myTabBar('详情','left',context,isLeft),_myTabBar('评论','right',context,isRight)
            ],
          ),
        );
      },
    );
  }

  //自定义tabbar
  Widget _myTabBar(String title,String leftOrRight,BuildContext context,bool isSelect){
    return InkWell(
      onTap: (){
        Provide.value<DetailInfoProvider>(context).changeLeftAndRight(leftOrRight);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(width: 1.0,color: isSelect?Colors.pink:Colors.black12))
        ),

        child: Text(title, style: TextStyle(color: isSelect?Colors.pink:Colors.black),),
      ),
    );
  }
}
