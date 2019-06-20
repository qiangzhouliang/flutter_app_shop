//商品详情模型
class DetailsModel {
  String code;
  String message;
  DetailsGoodsData data;

  DetailsModel({this.code, this.message, this.data});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.message = json['message'];
    this.data = json['data'] != null ? DetailsGoodsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

}

class DetailsGoodsData {
  AdvertesPictureBean advertesPicture;
  GoodInfoBean goodInfo;
  List<GoodCommentsListBean> goodComments;

  DetailsGoodsData({this.advertesPicture, this.goodInfo, this.goodComments});

  DetailsGoodsData.fromJson(Map<String, dynamic> json) {
    this.advertesPicture = json['advertesPicture'] != null ? AdvertesPictureBean.fromJson(json['advertesPicture']) : null;
    this.goodInfo = json['goodInfo'] != null ? GoodInfoBean.fromJson(json['goodInfo']) : null;
    this.goodComments = (json['goodComments'] as List)!=null?(json['goodComments'] as List).map((i) => GoodCommentsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.advertesPicture != null) {
      data['advertesPicture'] = this.advertesPicture.toJson();
    }
    if (this.goodInfo != null) {
      data['goodInfo'] = this.goodInfo.toJson();
    }
    data['goodComments'] = this.goodComments != null?this.goodComments.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class AdvertesPictureBean {
  String PICTUREPICTUREADDRESS;
  String TOTOPLACE;

  AdvertesPictureBean({this.PICTUREPICTUREADDRESS, this.TOTOPLACE});

  AdvertesPictureBean.fromJson(Map<String, dynamic> json) {    
    this.PICTUREPICTUREADDRESS = json['PICTURE_ADDRESS'];
    this.TOTOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.PICTUREPICTUREADDRESS;
    data['TO_PLACE'] = this.TOTOPLACE;
    return data;
  }
}

class GoodInfoBean {
  String image5;
  String image3;
  String image4;
  String goodsId;
  String isOnline;
  String image1;
  String image2;
  String goodsSerialNumber;
  String comPic;
  String shopId;
  String goodsName;
  String goodsDetail;
  double oriPrice;
  double presentPrice;
  int amount;
  int state;

  GoodInfoBean({this.image5, this.image3, this.image4, this.goodsId, this.isOnline, this.image1, this.image2, this.goodsSerialNumber, this.comPic, this.shopId, this.goodsName, this.goodsDetail, this.oriPrice, this.presentPrice, this.amount, this.state});

  GoodInfoBean.fromJson(Map<String, dynamic> json) {    
    this.image5 = json['image5'];
    this.image3 = json['image3'];
    this.image4 = json['image4'];
    this.goodsId = json['goodsId'];
    this.isOnline = json['isOnline'];
    this.image1 = json['image1'];
    this.image2 = json['image2'];
    this.goodsSerialNumber = json['goodsSerialNumber'];
    this.comPic = json['comPic'];
    this.shopId = json['shopId'];
    this.goodsName = json['goodsName'];
    this.goodsDetail = json['goodsDetail'];
    this.oriPrice = json['oriPrice'];
    this.presentPrice = json['presentPrice'];
    this.amount = json['amount'];
    this.state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image5'] = this.image5;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['goodsId'] = this.goodsId;
    data['isOnline'] = this.isOnline;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['goodsSerialNumber'] = this.goodsSerialNumber;
    data['comPic'] = this.comPic;
    data['shopId'] = this.shopId;
    data['goodsName'] = this.goodsName;
    data['goodsDetail'] = this.goodsDetail;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['amount'] = this.amount;
    data['state'] = this.state;
    return data;
  }
}

class GoodCommentsListBean {
  String comments;
  String userName;
  int SCORE;
  num discussTime;

  GoodCommentsListBean({this.comments, this.userName, this.SCORE, this.discussTime});

  GoodCommentsListBean.fromJson(Map<String, dynamic> json) {    
    this.comments = json['comments'];
    this.userName = json['userName'];
    this.SCORE = json['SCORE'];
    this.discussTime = json['discussTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = this.comments;
    data['userName'] = this.userName;
    data['SCORE'] = this.SCORE;
    data['discussTime'] = this.discussTime;
    return data;
  }
}
