import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app_shop/model/CartInfo.dart';
import 'cart_count.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app_shop/provide/cart.dart';
//购物车子项
class CartItem extends StatelessWidget {
  final CartInfoModel item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    print(item);
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
          //复选框
          _cartCheckBt(context,item),
          //商品图片
          _cartImage(),
          //商品名称
          _cartGoodsName(),
          //商品价格
          _cartPrice(context,item),
        ],
      ),
    );
  }

  //多选按钮
  Widget _cartCheckBt(context,CartInfoModel item){
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged:(bool val){
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeCheckState(item);
        },
      ),
    );
  }

  //商品图片
  Widget _cartImage(){
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0,color: Colors.black12,),
      ),
      child: Image.network(item.images),
    );
  }

  //商品名称
  Widget _cartGoodsName(){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName,),
          Container(
            alignment: Alignment.centerLeft,
            child: CartCount(item),
          )
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(context,CartInfoModel item){
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          //删除按钮
          Container(
            child: InkWell(
              onTap: (){
                Provide.value<CartProvide>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(Icons.delete_forever,color: Colors.black26,size: 30,),
            ),
          ),
        ],
      ),
    );
  }
}
