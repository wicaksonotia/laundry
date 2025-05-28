import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:laundry/models/category_model.dart';
import 'package:laundry/models/service_model.dart';
import 'package:laundry/models/transaction_model.dart';
import 'package:laundry/models/transaction_detail_model.dart';
import 'package:laundry/networks/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteDataSource {
  static Future<bool> login(FormData data) async {
    try {
      Dio dio = Dio();
      var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.login;
      Response response = await dio.post(
        url,
        data: data,
        options: Options(contentType: Headers.jsonContentType),
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.data['status'] == 'ok') {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('statusLogin', true);
          await prefs.setString('username', response.data['username']);
          await prefs.setString('alamat', response.data['alamat']);
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // GET CATEGORIES
  static Future<List<CategoryModel>?> getCategories() async {
    try {
      var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.categories;
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map((e) => CategoryModel.fromJson(e)).toList();
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // GET SERVICES
  static Future<List<ServiceModel>?> getServices(String id) async {
    try {
      var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.services;
      final response = await Dio().get('$url?category=$id');
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        // print(jsonData);
        return jsonData.map((e) => ServiceModel.fromJson(e)).toList();
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // GET ROW TRANSACTION BY NUMERATOR AND KIOS
  static Future<TransactionModel?> getRowTransaction(
    Map<String, dynamic> data,
  ) async {
    try {
      var rawFormat = jsonEncode(data);
      var url =
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getRowTransaction;
      final response = await Dio().post(
        url,
        data: rawFormat,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        dynamic jsonData = response.data;
        return TransactionModel.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // GET LIST TRANSACTION
  static Future<List<TransactionModel>?> getListTransactions(
    DateTime startdate,
    DateTime enddate,
  ) async {
    try {
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      var rawFormat = (jsonEncode({
        'startdate': startdate.toString(),
        'enddate': enddate.toString(),
        // 'kios': prefs.getString('username'),
        'kios': 'laundry-stg',
      }));
      var url =
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getListTransaction;
      Response response = await Dio().post(
        url,
        data: rawFormat,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map((e) => TransactionModel.fromJson(e)).toList();
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // GET LIST TRANSACTION DETAIL BY NUMERATOR AND KIOS
  static Future<List<TransactionDetailModel>?> getDetailTransaction(
    Map<String, dynamic> data,
  ) async {
    try {
      var rawFormat = jsonEncode(data);
      var url =
          ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.getDetailTransaction;
      final response = await Dio().post(
        url,
        data: rawFormat,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        // print(jsonData);
        return jsonData.map((e) => TransactionDetailModel.fromJson(e)).toList();
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // SAVE DETAIL TRANSACTION
  static Future<bool> saveDetailTransaction(List<dynamic> data) async {
    try {
      var rawFormat = jsonEncode(data);
      Dio dio = Dio();
      var url =
          ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.saveDetailTransaction;
      Response response = await dio.post(
        url,
        data: rawFormat,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'numerator',
          response.data['numerator'].toString(),
        );
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  // SAVE TRANSACTION
  static Future<bool> saveTransaction(Map<String, dynamic> data) async {
    try {
      var rawFormat = jsonEncode(data);
      Dio dio = Dio();
      var url =
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.saveTransaction;
      Response response = await dio.post(
        url,
        data: rawFormat,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  //UPDATE STATUS
  static Future<bool> updateStatus(Map<String, dynamic> data) async {
    try {
      var rawFormat = jsonEncode(data);
      Dio dio = Dio();
      var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.updateStatus;
      Response response = await dio.post(
        url,
        data: rawFormat,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  static Future<TransactionModel?> transactionHistoryByDateRange(
    Map<String, dynamic> data,
  ) async {
    try {
      var rawFormat = Map<String, dynamic>.from(data);
      rawFormat['startDate'] = data['startDate'].toString();
      rawFormat['endDate'] = data['endDate'].toString();
      var url =
          ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.transactionHistoryByDateRange;
      Response response = await Dio().post(
        url,
        data: jsonEncode(rawFormat),
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        final TransactionModel res = TransactionModel.fromJson(response.data);
        return res;
      }
      return null;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  static Future<TransactionModel?> transactionHistoryByMonth(
    Map<String, dynamic> data,
  ) async {
    try {
      var rawFormat = jsonEncode(data);
      // print(rawFormat);
      var url =
          ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.transactionHistoryByMonth;
      Response response = await Dio().post(
        url,
        data: rawFormat,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        final TransactionModel res = TransactionModel.fromJson(response.data);
        return res;
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
