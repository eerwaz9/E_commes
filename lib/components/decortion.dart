import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String myUri01 = "http://10.0.2.2:3020";

class Decortion {
  static const appBarGradent = LinearGradient(colors: [
    Color.fromARGB(255, 201, 29, 126),
    Color.fromARGB(255, 221, 125, 187),
  ], stops: [
    0.5,
    1.0
  ]);
  static const appBarGradent2 = LinearGradient(colors: [
    Color.fromARGB(255, 158, 196, 213),
    Color.fromARGB(255, 115, 161, 178),
  ], stops: [
    0.5,
    1.0
  ]);
  static const secondergray = Color.fromRGBO(170, 208, 102, 1.0);
  static const backgruondColor = Color(0xdbffffff);
  static const Color greyBackgroubdColor = Color(0xffd6d7f1);
  static var selectNavBarColor = const Color.fromARGB(255, 41, 59, 185);
  static const NuselectNavBarColor = Color.fromARGB(255, 0, 0, 0);

  static const List<Map<String, String>> categories = [
    {
      'title': 'Mobil',
      'image': 'assets/images/h.png',
    },
    {
      'title': 'iPad',
      'image': 'assets/images/e.png',
    },
    {
      'title': 'computer',
      'image': 'assets/images/c.png',
    },
    {
      'title': 'keyboard',
      'image': 'assets/images/d.png',
    },
    {
      'title': 'Story',
      'image': "assets/images/f.png",
    },
  ];

  static const List<String> ousleImage = [
    'https://envato-shoebox-0.imgix.net/b653/b7f1-f047-43a5-a405-f36350353801/MON1217181.jpg?auto=compress%2Cformat&fit=max&mark=https%3A%2F%2Felements-assets.envato.com%2Fstatic%2Fwatermark2.png&markalign=center%2Cmiddle&markalpha=18&w=400&s=195f193a126f2d6bc5036037feae3d7a',
    'https://envato-shoebox-0.imgix.net/8018/9f45-acd7-4371-967a-272df163fe5a/DSCF7864.jpg?auto=compress%2Cformat&fit=max&mark=https%3A%2F%2Felements-assets.envato.com%2Fstatic%2Fwatermark2.png&markalign=center%2Cmiddle&markalpha=18&w=800&s=143adfca3a7fc6086f7937ab4f83bc0d',
    'https://elements-cover-images-0.imgix.net/ebbd595e-0b0a-4225-88b4-86114454d130?auto=compress%2Cformat&fit=max&w=1170&s=16008ed7d208e1d84e0b928e8ca611d8',
    'https://elements-cover-images-0.imgix.net/0cef585e-7cbe-4889-a64b-61b1acbd5426?auto=compress%2Cformat&fit=max&w=1170&s=28df2860d506d07d5096b2b496193e42',
    'https://elements-cover-images-0.imgix.net/d071fa8d-4838-4323-9417-d2d2f5c82b50?auto=compress%2Cformat&fit=max&w=1170&s=b3a46f181dc4a0d8a272e59d78e087e3',
  ];


  static double checkDouble(dynamic vale){
    if(vale is int){
      return vale.toDouble();
    }else if(vale is String){
      return double.parse(vale);
    }else{
      return vale;
    }
  }
}

class ColorAPP {
  static final Color COLOR_TEXT_SPLASH_SCREAN_RGB =
      Color.fromARGB(255, 255, 255, 255);
  static final Color COLOR_TEXT_SPLASH_SCREAN_RGB_Whith_opcity =
      Color.fromARGB(255, 255, 255, 255).withOpacity(0.5);
  static final Color COLOR_TEXT_SPLASH_SCREAN = Color(0xFFFFFFFF);

  static var Color_side_bar = Color(0xFFFC0000).withOpacity(0.9);
  static var Color_Clip_Path = Color(0xFFFC0000).withOpacity(0.7);
  static var Color_Clip_Path_icon = Color(0xFFFFFFFF).withOpacity(0.9);

  static Color lightGreen = Color(0xFF2F1853);

  //static Color lightGreen = Color(0xFF90278E);
  //static Color lightGreen = Color(0xFFAC0056);

  // static Color lightGreen = Color(0xff4a40a1);
  static Color lightBlueIsh = Color(0xFF66BF61);
  static Color darkGreen = Color(0xFF66BF61);
  static Color backgroundColor = Color(0xFFFFFFFF).withOpacity(0.9);
  static Color colorWhite = Color(0xFFFFFFFF).withOpacity(0.3);
  static Color BlackColorWithOpacity = Color(0xFF000000).withOpacity(0.2);
  static Color BlackColor = Color(0xFF000000);

  static Color SkyColor = Color.fromARGB(255, 144, 143, 143);

}
