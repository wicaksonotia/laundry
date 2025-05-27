class TransactionDetailModel {
  int? id;
  int? numerator;
  String? transactionDate;
  String? kios;
  int? idService;
  String? serviceName;
  String? quantity;
  int? unitPrice;
  int? totalPrice;
  bool? deleteStatus;

  TransactionDetailModel({
    this.id,
    this.numerator,
    this.transactionDate,
    this.kios,
    this.idService,
    this.serviceName,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.deleteStatus,
  });

  TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numerator = json['numerator'];
    transactionDate = json['transaction_date'];
    kios = json['kios'];
    idService = json['id_service'];
    serviceName = json['service_name'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
    deleteStatus = json['delete_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['numerator'] = numerator;
    data['transaction_date'] = transactionDate;
    data['kios'] = kios;
    data['id_service'] = idService;
    data['service_name'] = serviceName;
    data['quantity'] = quantity;
    data['unit_price'] = unitPrice;
    data['total_price'] = totalPrice;
    data['delete_status'] = deleteStatus;
    return data;
  }
}
