import 'package:flutter/material.dart';
import '../model/category_model.dart';
//分类状态控制中间类
class ChildCategory with ChangeNotifier{
  List<BxMallSubDtoListBean> childCategoryList = [];
  //子类高亮索引
  int childIndex = 0;
  //大类类别id
  String categoryId = '4';
  //小类类别id
  String subId = '';
  //列表页数
  int page = 1;
  //没有数据的文字
  String noMoreText = '';
  //大类切换逻辑
  getChildCategory(List<BxMallSubDtoListBean> list,String id){
    page = 1;
    noMoreText = '';
    categoryId = id;
    childIndex = 0;
    //添加第一项全部
    BxMallSubDtoListBean all = BxMallSubDtoListBean(mallSubId: '',mallCategoryId: '00',comments: 'null',mallSubName: '全部');
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index,String id){
    page = 1;
    noMoreText = '';
    subId = id;
    childIndex = index;
    notifyListeners();
  }

  //增加page的方法
  addPage(){
      page++;
  }
  //改变无数据时显示的内容
  changeNoMore(String text){
    noMoreText = text;
    notifyListeners();
  }
}