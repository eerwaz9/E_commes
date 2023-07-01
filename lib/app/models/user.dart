// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class User {
  final String Id;
  final String name;
  final String email;
  final String password;
  final String type;
  final String token;
  final String address;
  final List<dynamic> cart;

  User(
      // ignore: non_constant_identifier_names
      {required this.Id,
      required this.name,
      required this.email,
      required this.address,
      required this.password,
      required this.type,
      required this.token,
        required this.cart});
  factory User.getNewEmpty() {
    return User(
      Id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '',
      cart:[]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Id": Id,
      "name": name,
      "email": email,
      "password": password,
      "address": address,
      "type": type,
      "token": token,
      "cart":cart
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      Id: json["_Id"] ?? '',
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
      address: json["address"] ?? '',
      type: json["type"] ?? '',
      token: json["token"] ?? '',
      cart: List<Map<String,dynamic>>.from(
        json['cart']?.map(
            (x)=>Map<String,dynamic>.from(x)
        )
    )
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  User copyWith({
     String? Id,
     String? name,
     String? email,
     String? password,
     String? type,
     String? token,
     String? address,
     List<dynamic>? cart,
}){
    return User(
        Id:Id ?? this.Id,
      name:name ?? this.name,
      email:email ?? this.email,
      password:password ?? this.password,
      type:type ?? this.type,
      token:token ?? this.token,
      address:address ?? this.address,
      cart:cart ?? this.cart,
    );
}
}
