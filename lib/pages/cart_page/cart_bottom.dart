import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app_shop/provide/cart.dart';


class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Provide<CartProvide>(
        builder: (context,child,val){
          return Row(
            children: <Widget>[
              _selectAllBtn(context),_allPriceArea(context),_goButton(context)
            ],
          );
        },
      ),
    );
  }

  //全选按钮
  Widget _selectAllBtn(context){
    //是否全选中
    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val){
              Provide.value<CartProvide>(context).changeAllCheckBtn(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  //合计区域
  Widget _allPriceArea(context){
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text('合计：',style: TextStyle(fontSize: ScreenUtil().setSp(36)),),
              ),
              //价格
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text('￥${allPrice}', style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Colors.red),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text('满10元免派送费，预购免派送费',style: TextStyle(color: Colors.black38,fontSize: ScreenUtil().setSp(22)),),
          )
        ],
      ),
    );
  }

  //结算
  Widget _goButton(context){
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10,),
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text('结算(${allGoodsCount})',style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
