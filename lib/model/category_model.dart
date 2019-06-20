class CategoryModel {
  String code;
  String message;
  List<DataListBean> data;

  CategoryModel({this.code, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.message = json['message'];
    this.data = (json['data'] as List)!=null?(json['data'] as List).map((i) => DataListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data != null?this.data.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class DataListBean {
  String mallCategoryId;//类别编号
  String mallCategoryName; //类别名称
  String comments;
  String image;
  List<BxMallSubDtoListBean> bxMallSubDto;

  DataListBean({this.mallCategoryId, this.mallCategoryName, this.comments, this.image, this.bxMallSubDto});

  DataListBean.fromJson(Map<String, dynamic> json) {    
    this.mallCategoryId = json['mallCategoryId'];
    this.mallCategoryName = json['mallCategoryName'];
    this.comments = json['comments'];
    this.image = json['image'];
    this.bxMallSubDto = (json['bxMallSubDto'] as List)!=null?(json['bxMallSubDto'] as List).map((i) => BxMallSubDtoListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallCategoryName'] = this.mallCategoryName;
    data['comments'] = this.comments;
    data['image'] = this.image;
    data['bxMallSubDto'] = this.bxMallSubDto != null?this.bxMallSubDto.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class BxMallSubDtoListBean {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  BxMallSubDtoListBean({this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});

  BxMallSubDtoListBean.fromJson(Map<String, dynamic> json) {    
    this.mallSubId = json['mallSubId'];
    this.mallCategoryId = json['mallCategoryId'];
    this.mallSubName = json['mallSubName'];
    this.comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallSubId'] = this.mallSubId;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallSubName'] = this.mallSubName;
    data['comments'] = this.comments;
    return data;
  }
}
