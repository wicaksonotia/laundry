import 'dart:convert';
import 'dart:typed_data';

class ServiceModel {
  int? id;
  String? serviceName;
  String? satuan;
  int? categoryId;
  String? categoryName;
  int? price;
  Uint8List? photo;

  ServiceModel({
    this.id,
    this.serviceName,
    this.satuan,
    this.categoryId,
    this.categoryName,
    this.price,
    this.photo,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    satuan = json['satuan'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    price = json['price'];
    Uint8List decodePhoto;
    decodePhoto = const Base64Decoder().convert('${json['photo']}');
    photo = decodePhoto;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_name'] = serviceName;
    data['satuan'] = satuan;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['price'] = price;
    data['photo'] = photo;
    return data;
  }
}
