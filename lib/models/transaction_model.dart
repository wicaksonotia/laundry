class TransactionModel {
  int? id;
  int? numerator;
  String? transactionDate;
  String? kios;
  int? grandTotal;
  int? discount;
  int? total;
  bool? deleteStatus;
  String? orderType;
  List<TransactionDetailModel>? details;

  TransactionModel({
    this.id,
    this.numerator,
    this.transactionDate,
    this.kios,
    this.grandTotal,
    this.discount,
    this.total,
    this.deleteStatus,
    this.orderType,
    this.details,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numerator = json['numerator'];
    transactionDate = json['transaction_date'];
    kios = json['kios'];
    grandTotal = json['grand_total'];
    discount = json['discount'];
    total = json['total'];
    deleteStatus = json['delete_status'];
    orderType = json['order_type'];
    if (json['details'] != null) {
      details = <TransactionDetailModel>[];
      json['details'].forEach((v) {
        details!.add(new TransactionDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['numerator'] = numerator;
    data['transaction_date'] = transactionDate;
    data['kios'] = kios;
    data['grand_total'] = grandTotal;
    data['discount'] = discount;
    data['total'] = total;
    data['delete_status'] = deleteStatus;
    data['order_type'] = orderType;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionDetailModel {
  String? productName;
  double? quantity;
  int? unitPrice;
  int? totalPrice;

  TransactionDetailModel({
    this.productName,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
  });

  TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['quantity'] = quantity;
    data['unit_price'] = unitPrice;
    data['total_price'] = totalPrice;
    return data;
  }
}
