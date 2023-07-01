import 'package:flutter/material.dart';
import 'package:shoping/components/utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key,required this.image,required this.text}) : super(key: key);

  final String image ;

  final String text ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          'Shoping',
          style: TextStyle(
              fontSize: getProportionateScreenWidth(36, context),
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        const Spacer(
          flex: 2,
        ),
        Image.asset(
          image,
          width: getProportionateScreenWidth(235, context),
          height: getProportionateScreenHeight(265, context),
        )
      ],
    );
  }
}
