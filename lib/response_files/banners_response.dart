/// status : true
/// message : null
/// data : [{"id":11,"image":"https://student.valuxapps.com/storage/uploads/banners/1619472351ITAM5.3bb51c97376281.5ec3ca8c1e8c5.jpg","category":null,"product":null},{"id":12,"image":"https://student.valuxapps.com/storage/uploads/banners/1619472116OYHxC.45b7de97376281.5ec3ca8c1d324.jpg","category":null,"product":null},{"id":17,"image":"https://student.valuxapps.com/storage/uploads/banners/1626544896muQ0Q.best-deal-promotional-ribbon-style-green-banner-design_1017-27469.jpg","category":null,"product":null},{"id":19,"image":"https://student.valuxapps.com/storage/uploads/banners/1626545208UfigP.golden-coin-money-cashback-promotion-ecommerce-poster-banner-template-blue-background-216757528.jpg","category":null,"product":null},{"id":23,"image":"https://student.valuxapps.com/storage/uploads/banners/16283378549Vinn.banner foods@2x.png","category":null,"product":null},{"id":24,"image":"https://student.valuxapps.com/storage/uploads/banners/1641000123OrbOP.BALCK-White-FRIDAY-AR21112019.jpg","category":null,"product":null},{"id":25,"image":"https://student.valuxapps.com/storage/uploads/banners/1641000140NnSq9.black-friday-cyber-monday-sales.jpg","category":null,"product":null},{"id":26,"image":"https://student.valuxapps.com/storage/uploads/banners/1641000163w2k1O.انطلاق-عروض-الجمعة-السوداء-Black-Friday-على-متجر-TomTop.jpg","category":null,"product":null}]

class BannersResponse {
  BannersResponse({
      bool? status, 
      dynamic message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  BannersResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  dynamic _message;
  List<Data>? _data;

  bool? get status => _status;
  dynamic get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 11
/// image : "https://student.valuxapps.com/storage/uploads/banners/1619472351ITAM5.3bb51c97376281.5ec3ca8c1e8c5.jpg"
/// category : null
/// product : null

class Data {
  Data({
      int? id, 
      String? image, 
      dynamic category, 
      dynamic product,}){
    _id = id;
    _image = image;
    _category = category;
    _product = product;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _category = json['category'];
    _product = json['product'];
  }
  int? _id;
  String? _image;
  dynamic _category;
  dynamic _product;

  int? get id => _id;
  String? get image => _image;
  dynamic get category => _category;
  dynamic get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['category'] = _category;
    map['product'] = _product;
    return map;
  }

}