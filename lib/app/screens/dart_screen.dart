import 'package:flutter/material.dart';
import 'package:shoping/app/screens/Auth_screen.dart';
import 'package:shoping/app/screens/splash_screen.dart';
import 'package:shoping/app/widgets/custem_butten.dart';
import 'package:shoping/components/decortion.dart';
import 'package:shoping/components/utils.dart';

class DartScreen extends StatefulWidget {
  const DartScreen({Key? key}) : super(key: key);

  @override
  State<DartScreen> createState() => _DartScreenState();
}

class _DartScreenState extends State<DartScreen> {
  int currentindex = 0;
  List<Map<String, String>> pageList = [
    {'image': 'assets/images/f.png', 'text': 'shoping in app and buy in app'},
    {'image': 'assets/images/b.png', 'text': 'shoping in app and buy in app'},
    {'image': 'assets/images/d.png', 'text': 'shoping in app and buy in app'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentindex = value;
                    });
                  },
                  itemCount: pageList.length,
                  itemBuilder: (context, index) => SplashScreen(
                    image: pageList[index]['image']!,
                    text: pageList[index]['text']!,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20, context)),
                child: Column(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            pageList.length, (index) => builder(index: index))),
                    const Spacer(
                      flex: 3,
                    ),
                    Custembutten(text: 'open app', onTap: () {
                      Navigator.pushNamed(context, AuthScreen.routName);
                    }),
                    const Spacer(),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer builder({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentindex == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentindex == index
              ? Decortion.selectNavBarColor
              : const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
