class TransactionModel {
  String? status;
  String? message;
  int? income;
  List<DataTransaction>? data;

  TransactionModel({this.status, this.message, this.income, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    income = json['income'];
    if (json['data'] != null) {
      data = <DataTransaction>[];
      json['data'].forEach((v) {
        data!.add(DataTransaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['income'] = income;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataTransaction {
  int? id;
  int? numerator;
  String? transactionDate;
  String? kios;
  int? total;
  int? discount;
  int? grandTotal;
  bool? paymentStatus;
  bool? washing;
  String? washingTime;
  bool? drying;
  String? dryingTime;
  bool? ironing;
  String? ironingTime;
  bool? delivering;
  String? deliveringTime;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  bool? completed;
  String? completedTime;
  bool? karpet;
  List<DataTransactionDetails>? details;

  DataTransaction({
    this.id,
    this.numerator,
    this.transactionDate,
    this.kios,
    this.total,
    this.discount,
    this.grandTotal,
    this.paymentStatus,
    this.washing,
    this.washingTime,
    this.drying,
    this.dryingTime,
    this.ironing,
    this.ironingTime,
    this.delivering,
    this.deliveringTime,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.completed,
    this.completedTime,
    this.karpet,
    this.details,
  });

  DataTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numerator = json['numerator'];
    transactionDate = json['transaction_date'];
    kios = json['kios'];
    total = json['total'];
    discount = json['discount'];
    grandTotal = json['grand_total'];
    paymentStatus = json['payment_status'];
    washing = json['washing'];
    washingTime = json['washing_time'];
    drying = json['drying'];
    dryingTime = json['drying_time'];
    ironing = json['ironing'];
    ironingTime = json['ironing_time'];
    delivering = json['delivering'];
    deliveringTime = json['delivering_time'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    completed = json['completed'];
    completedTime = json['completed_time'];
    karpet = json['karpet'];
    if (json['details'] != null) {
      details = <DataTransactionDetails>[];
      json['details'].forEach((v) {
        details!.add(DataTransactionDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['numerator'] = numerator;
    data['transaction_date'] = transactionDate;
    data['kios'] = kios;
    data['total'] = total;
    data['discount'] = discount;
    data['grand_total'] = grandTotal;
    data['payment_status'] = paymentStatus;
    data['washing'] = washing;
    data['washing_time'] = washingTime;
    data['drying'] = drying;
    data['drying_time'] = dryingTime;
    data['ironing'] = ironing;
    data['ironing_time'] = ironingTime;
    data['delivering'] = delivering;
    data['delivering_time'] = deliveringTime;
    data['customer_name'] = customerName;
    data['customer_phone'] = customerPhone;
    data['customer_address'] = customerAddress;
    data['completed'] = completed;
    data['completed_time'] = completedTime;
    data['karpet'] = karpet;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataTransactionDetails {
  String? serviceName;
  String? quantity;
  int? unitPrice;
  int? totalPrice;

  DataTransactionDetails({
    this.serviceName,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
  });

  DataTransactionDetails.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_name'] = serviceName;
    data['quantity'] = quantity;
    data['unit_price'] = unitPrice;
    data['total_price'] = totalPrice;
    return data;
  }
}
