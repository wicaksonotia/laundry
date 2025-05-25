class TransactionModel {
  int? id;
  int? numerator;
  String? transactionDate;
  String? kios;
  int? grandTotal;
  int? discount;
  int? total;
  bool? paymentStatus;
  bool? washing;
  DateTime? washingTime;
  bool? drying;
  DateTime? dryingTime;
  bool? ironing;
  DateTime? ironingTime;
  bool? delivering;
  DateTime? deliveringTime;
  bool? completed;
  DateTime? clompletedTime;
  late String customerName;
  late String customerPhone;
  late String customerAddress;
  List<TransactionDetailModel>? details;

  TransactionModel({
    this.id,
    this.numerator,
    this.transactionDate,
    this.kios,
    this.grandTotal,
    this.discount,
    this.total,
    this.paymentStatus,
    this.washing,
    this.washingTime,
    this.drying,
    this.dryingTime,
    this.ironing,
    this.ironingTime,
    this.delivering,
    this.deliveringTime,
    this.completed,
    this.clompletedTime,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
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
    paymentStatus = json['payment_status'];
    washing = json['washing'];
    if (json['washing_time'] != null) {
      washingTime = DateTime.parse(json['washing_time']);
    }
    drying = json['drying'];
    if (json['drying_time'] != null) {
      dryingTime = DateTime.parse(json['drying_time']);
    }
    ironing = json['ironing'];
    if (json['ironing_time'] != null) {
      ironingTime = DateTime.parse(json['ironing_time']);
    }
    delivering = json['delivering'];
    if (json['delivering_time'] != null) {
      deliveringTime = DateTime.parse(json['delivering_time']);
    }
    completed = json['completed'];
    if (json['clompleted_time'] != null) {
      clompletedTime = DateTime.parse(json['clompleted_time']);
    }
    customerName = json['customer_name'] ?? '';
    customerPhone = json['customer_phone'] ?? '';
    customerAddress = json['customer_address'] ?? '';
    if (json['details'] != null) {
      details = <TransactionDetailModel>[];
      json['details'].forEach((v) {
        details!.add(TransactionDetailModel.fromJson(v));
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
    data['payment_status'] = paymentStatus;
    data['washing'] = washing;
    if (washingTime != null) {
      data['washing_time'] = washingTime!.toIso8601String();
    }
    data['drying'] = drying;
    if (dryingTime != null) {
      data['drying_time'] = dryingTime!.toIso8601String();
    }
    data['ironing'] = ironing;
    if (ironingTime != null) {
      data['ironing_time'] = ironingTime!.toIso8601String();
    }
    data['delivering'] = delivering;
    if (deliveringTime != null) {
      data['delivering_time'] = deliveringTime!.toIso8601String();
    }
    data['completed'] = completed;
    if (clompletedTime != null) {
      data['clompleted_time'] = clompletedTime!.toIso8601String();
    }
    data['customer_name'] = customerName;
    data['customer_phone'] = customerPhone;
    data['customer_address'] = customerAddress;
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
