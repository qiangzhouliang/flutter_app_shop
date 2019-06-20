class CategoryGoodsListModel {
  String code;
  String message;
  List<CategoryListData> data;

  CategoryGoodsListModel({this.code, this.message, this.data});

  CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.message = json['message'];
    this.data = (json['data'] as List)!=null?(json['data'] as List).map((i) => CategoryListData.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data != null?this.data.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class CategoryListData {
  String image;
  String goodsName;
  String goodsId;
  double oriPrice;
  double presentPrice;

  CategoryListData({this.image, this.goodsName, this.goodsId, this.oriPrice, this.presentPrice});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    this.image = json['image'];
    this.goodsName = json['goodsName'];
    this.goodsId = json['goodsId'];
    this.oriPrice = json['oriPrice'];
    this.presentPrice = json['presentPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    return data;
  }
}
