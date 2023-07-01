import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/screens/acount_screen.dart';
import 'package:shoping/app/screens/cart_screen.dart';
import 'package:shoping/app/screens/home_screen.dart';
import 'package:badges/badges.dart'as badges;

import '../providers/user_provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, });

  static const String routeName = "/an-home";
  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
   late bool ifCart=true;
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final contacrd=context.watch<UserProvider>().user.cart.length;
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items:  [
            Icon(
              Icons.home_outlined,
              size: 30,
            ),
            Icon(Icons.person_2_outlined, size: 30),
            Container(
                child: ifCart? badges.Badge(
              elevation: 0,
              badgeContent:  Text(contacrd.toString()),
              badgeColor: Colors.red,

            ) :Icon(Icons.person_2_outlined)
            )
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _page == 0
            ? const homeScreen()
            : _page == 1
                ? const AcountScreen()
                : const CardScreen());
  }
}
