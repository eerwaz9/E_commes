import 'dart:convert';
import 'package:shoping/app/models/rating.dart';

class Prodect {
  final String name;
  final String description;
  final String category;
  final int price;
  final int qty;
  final List<String> images;
  String? id;
  String? userId;
  final List<Rating>? rating;
  double? selQty;

  Prodect(
      {required this.name,
        required this.description,
        required this.category,
        required this.price,
        required this.qty,
        required this.images,
        this.id,
        this.userId,
         this.rating,
      });
  factory Prodect.getNewEmpty() {
    return Prodect(
      name: '',
      description: '',
      category: '',
      price: 0,
      qty: 0,
      images: [],
      id: '',
      userId: '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "category": category,
      "price": price,
      "qty": qty,
      "images": images,
      "id": id,
      "userId": userId,
      "rating":rating,
    };
  }

  factory Prodect.fromMap(Map<String, dynamic> json) {
    return Prodect(
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      category: json["category"] ?? '',
      price: json["price"] ?? 0.00,
      qty: json["qty"] ?? 0.00,
      images: List<String>.from(json["images"] ),
      id: json["_id"],
      userId: json["userId"],
      rating: json["rating"] !=null ? List<Rating>.from(
          json["rating"]?.map(
              (x)=>Rating.fromMap(x),
          )
      ):null,

    );
  }
  String toJson() => json.encode(toMap());
  factory Prodect.fromJson(String source) =>
      Prodect.fromMap(json.decode(source));
}
