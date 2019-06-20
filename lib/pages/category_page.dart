import 'package:flutter/material.dart';
import 'package:flutter_app_shop/service/service_method.dart';
import 'dart:convert';
import 'package:flutter_app_shop/model/category_model.dart';
import 'package:flutter_app_shop/model/categoryGoodsList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app_shop/provide/child_category.dart';
import 'package:flutter_app_shop/provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app_shop/router/application.dart';
//类别页面
class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Container(
        child: Row(
          children: <Widget>[
            //左侧部分
            LeftCategoryNav(),
            //右侧部分
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
          ],
        ),
      ),
    );
  }
}

//左侧类别导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<DataListBean> list = [];
  //点击的索引,默认选中第一个
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    //获取左侧大类列表信息
    _getCategory();
    //先初始化商品列表
    _getGoodsList();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 1,color: Colors.black12)
          )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return _leftInkWell(index);
        },
      ),
    );
  }

  //左侧一级类别
  Widget _leftInkWell(int index){
    bool isClick = false;
    isClick = (index == listIndex)?true:false;
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        //大类id
        var categoryId = list[index].mallCategoryId;
        //改变状态，将值放到一个变量里面
        Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0,top: 20.0),
        decoration: BoxDecoration(
          color: isClick? Color.fromRGBO(236, 236, 236, 1.0):Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
      ),
    );
  }
  //获取数据
  void _getCategory() async {
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      var category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      //改变状态，将值放到一个变量里面
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);
    });
  }

  //获取商品列表数据
  void _getGoodsList ({String categoryId}) async{
    var data = {
      'categoryId':categoryId == null?'4':categoryId,
      'categorySubId':'',
      'page':'1'
    };
    await request('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
  }
}

//右侧二级分类
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() {
    return _RightCategoryNavState();
  }
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context,child,childCategory){
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          //北京和下边线
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(width: 1,color: Colors.black12))
          ),
          child: ListView.builder(
            //横向
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context,index){
              return _rightInkWell(index,childCategory.childCategoryList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(int index,BxMallSubDtoListBean item){
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex)?true:false;
    return InkWell(
      onTap: (){
        Provide.value<ChildCategory>(context).changeChildIndex(index,item.mallSubId);
        _getGoodsList (item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28),color: isClick?Colors.pink:Colors.black),
        ),
      ),
    );
  }

  //获取商品列表数据
  void _getGoodsList (String categorySubId) async{
    var data = {
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page':'1'
    };
    await request('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if(goodsList.data == null){
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      }else{
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
      }
    });
  }
}

//商品列表，可以上拉加载效果
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  var scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){
        try{
          if(Provide.value<ChildCategory>(context).page == 1){
            //列表位置放到最上边
            scrollController.jumpTo(0.0);
          }
        }catch(e){
          print('进入页面第一次初始化：${e}');
        }
        if(data.goodsList.length > 0){
          //表示可伸缩的
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  //加载时显示的文字
                  moreInfo: '加载中...',
                  //准备文字
                  loadReadyText: '上拉加载更多',
                ),
                child:ListView.builder(
                  controller: scrollController,
                  itemCount: data.goodsList.length,
                  itemBuilder: (context,index){
                    return _ListWidget(data.goodsList,index);
                  },
                ),
                //加载更多回调
                loadMore: (){
                  _getMoreList ();
                },
              ),
            )
          );
        }else{
          return Text('暂时没有数据');
        }
      },
    );
  }
  //获取商品列表数据
  void _getMoreList (){
    Provide.value<ChildCategory>(context).addPage();
    var data = {
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':Provide.value<ChildCategory>(context).subId,
      'page':Provide.value<ChildCategory>(context).page
    };
    request('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if(goodsList.data == null){
        Fluttertoast.showToast(
            msg: "已经到底了",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
        Provide.value<CategoryGoodsListProvide>(context).getMoreList([]);
      }else{
        Provide.value<CategoryGoodsListProvide>(context).getMoreList(goodsList.data);
      }
    });
  }
  //商品图片
  Widget _goodsImage(List<CategoryListData> newList,index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }
  //商品名称
  Widget _goodsName(List<CategoryListData> newList,int index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }
  //商品价格
  Widget _goodsPrice(List<CategoryListData> newList,int index){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格: ￥${newList[index].presentPrice}',
            style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${newList[index].oriPrice}',
            style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
  //组合定义的组件
  Widget _ListWidget(List<CategoryListData> newList,int index){
    return InkWell(
      onTap: (){
        //页面跳转
        Application.router.navigateTo(context, '/detail?id=${newList[index].goodsId}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1.0,color: Colors.black12))
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList,index),
            Column(
              children: <Widget>[
                _goodsName(newList,index),_goodsPrice(newList,index),
              ],
            )
          ],
        ),
      ),
    );
  }
}


