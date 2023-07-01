import 'dart:convert';

import 'package:shoping/app/models/prodect.dart';

class Order {
  final String id;
  final List<Prodect>prodects;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final String paymentMethods;
  final double totalPrice;

  Order(
      {required this.id,
      required this.prodects,
      required this.address,
      required this.userId,
      required this.orderedAt,
      required this.status,
      required this.paymentMethods,
      required this.totalPrice});
  factory Order.getNewEmpty() {
    return Order(
      id: '',
      prodects: [],
      address: '',
      userId: '',
      orderedAt: 0,
      status: 0,
      paymentMethods: '',
      totalPrice: 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "prodects": prodects,
      "address": address,
      "userId": userId,
      "orderedAt": orderedAt,
      "status": status,
      "paymentMethods": paymentMethods,
      "totalPrice": totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> json) {
    return Order(
      id: json["_id"],
      prodects: List<Prodect>.from(json['prodects']?.map(
            (x) {
        var prodect = Prodect.fromMap(x['prodect']);
        prodect.selQty = x['qty']?.toDouble() ?? 0;
        return prodect;},),) ,
      address: json["address"] ?? '',
      userId: json["userId"] ?? '',
      orderedAt: json["orderTime"] ?? 0,
      status: json["status"] ?? 0,
      paymentMethods: json["paymentMethods"] ?? '',
      ///////////
      totalPrice: json["totalPrice"].toDouble() ?? 0.0,
    );
  }
  String toJson() => json.encode(toMap());
  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
