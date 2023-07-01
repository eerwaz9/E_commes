import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shoping/components/decortion.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: Decortion.ousleImage.map((e) {
        return Builder(
            builder: (BuildContext context) => Image.network(
                  e,
                  fit: BoxFit.cover,
                  height: 20,
                ));
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
// items:Decortion.ousleImage.map((e) => {
// return  Builder(
// builder: (BuildContext context)=>Image.network(
// e,fit: BoxFit.cover,height: 20,
// ));
// }).toList(),
