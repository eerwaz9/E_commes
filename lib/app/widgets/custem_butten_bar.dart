import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/app/screens/cart_screen.dart';
import 'package:shoping/app/screens/home_screen.dart';

import '../../components/decortion.dart';
import '../screens/acount_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  static const String routeName = "/bar-home";
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> pages = [
    const homeScreen(),
    const AcountScreen(),
    const CardScreen(),
  ];
  int _page = 0;
  double nbwidth = 42;
  void updatepag(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final contacrd=context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar:
      BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Decortion.selectNavBarColor,
        unselectedItemColor: Decortion.NuselectNavBarColor,
        backgroundColor: Decortion.backgruondColor,
        iconSize: 28,
        items: [
          getNavBottom(
              icon: Icons.home_outlined,
              title: "Home",
              index: 0,
              ifCart: false),
          getNavBottom(
              icon: Icons.person_2_outlined,
              title: "",
              index: 1,
              ifCart: false),
          getNavBottom(

              icon: Icons.shopping_cart, title: "", index: 2,
              ifCart: true,contacrd:contacrd),
        ],
        onTap: updatepag,
      ),
    );
  }

  BottomNavigationBarItem getNavBottom(
      {required IconData icon,
      required String title,
      required int index,
      required bool ifCart,
     int contacrd =0 }) {
    return BottomNavigationBarItem(
        icon: Container(
          width: nbwidth,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: _page == index
                      ? Decortion.selectNavBarColor
                      : Decortion.backgruondColor,
                  width: 5),
            ),
          ),
          child: ifCart
              ? badges.Badge(
                  elevation: 0,
                  badgeContent:  Text(contacrd.toString()),
                  badgeColor: Colors.red,
                  child: Icon(icon),
                )
              : Icon(icon),
        ),
        label: title);
  }
}
