import 'dart:convert';

import 'package:laundry/models/service_model.dart';

class CartModel {
  final ServiceModel serviceModel;
  final int id;
  double quantity;
  CartModel({
    required this.serviceModel,
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceModel': serviceModel,
      'id': id,
      'quantity': quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      serviceModel: ServiceModel.fromJson(
        map['serviceModel'] as Map<String, dynamic>,
      ),
      id: map['id'] as int,
      quantity: map['quantity'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
