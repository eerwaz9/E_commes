import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/app/screens/Post_screen.dart';
import 'package:shoping/app/screens/admin_order_screen.dart';
import 'package:shoping/app/screens/analytics_screen.dart';

import '../../components/decortion.dart';

class AdminScreen extends StatefulWidget {
  static const String routName = '/admin-screen';
  const AdminScreen({Key? key}) : super(key: key);
static const String routeName="/admin";
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Widget> pages = [
    const PostScreen(),
    const AnalyticsScreen(),
    const Center(
      child: AdminorderScreen(),
    ),
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
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:  const BoxDecoration(
            gradient: Decortion.appBarGradent,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Text(
            user.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Decortion.selectNavBarColor,
        unselectedItemColor: Decortion.NuselectNavBarColor,
        backgroundColor: Decortion.backgruondColor,
        iconSize: 28,
        items: [
          getNavBottom(
            icon: Icons.post_add_outlined,
            title: "Home",
            index: 0,
          ),
          getNavBottom(
            icon: Icons.analytics_outlined,
            title: "",
            index: 1,
          ),
          getNavBottom(icon: Icons.all_inbox_outlined, title: "Orders", index: 2),
        ],
        onTap: updatepag,
      ),
    );
  }

  BottomNavigationBarItem getNavBottom({
    required IconData icon,
    required String title,
    required int index,
  }) {
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
          child: Icon(icon),
        ),
        label: title);
  }
}
