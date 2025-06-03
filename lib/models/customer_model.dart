class CustomerModel {
  String? status;
  String? message;
  List<DataCustomer>? data;

  CustomerModel({this.status, this.message, this.data});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataCustomer>[];
      json['data'].forEach((v) {
        data!.add(DataCustomer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataCustomer {
  int? id;
  String? name;
  String? phone;
  String? address;

  DataCustomer({this.id, this.name, this.phone, this.address});

  DataCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}
