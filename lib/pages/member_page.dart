import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('会员中心'),),
      body: ListView(
        children: <Widget>[
          //顶部头像
          _topHeader(),
          //我的订单 标题
          _orderTitle(),
          //订单类型
          _orderType(),
          //下面小条目
          _actionList()
        ],
      ),
    );
  }

  //会员中心 - 头部
  Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            //圆形头像
            child: ClipOval(child: Image.network('https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2951924714,3607611016&fm=26&gp=0.jpg',width: ScreenUtil().setWidth(220),),),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('XXX',style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Colors.black54),),
          )
        ],
      ),
    );
  }

  //我的订单标题
  Widget _orderTitle(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1,color: Colors.black12))
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  //订单类型
  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.party_mode,size: 30,),
                Text('待付款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder,size: 30,),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.directions_car,size: 30,),
                Text('待收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.content_paste,size: 30,),
                Text('待评价')
              ],
            ),
          ),
        ],
      ),
    );
  }

  //通用listTitle
  Widget _myListTitle(String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1,color: Colors.black12)),
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
        onTap: (){
          Fluttertoast.showToast(
            msg: title,
            backgroundColor: Colors.pink,
            textColor: Colors.white
          );
        },
      ),
    );
  }

  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTitle('领取优惠券'),
          _myListTitle('已领取优惠券'),
          _myListTitle('地址管理'),
          _myListTitle('客服电话'),
          _myListTitle('关于我们'),
        ],
      ),
    );
  }
}