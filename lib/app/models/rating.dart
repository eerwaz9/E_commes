import 'dart:convert';

class Rating{
  final String userId;
  // ignore: prefer_typing_uninitialized_variables
  var  rating;

  Rating({required this.userId,required this.rating});
  factory Rating.getNewEmpty() {
    return Rating(
      userId: '',
      rating: 0,

    );
  }
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "rating": rating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> json) {
    return Rating(
      userId: json["userId"]??'',
      rating:json["rating"]??0.00,
    );
  }
  String toJson() => json.encode(toMap());
  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
//
}