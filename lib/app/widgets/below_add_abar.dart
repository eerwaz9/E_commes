import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/components/decortion.dart';

class BeloApp extends StatelessWidget {
  const BeloApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        gradient: Decortion.appBarGradent,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: user.name,
                style: const TextStyle(fontSize: 22, color: Colors.black),
                children: [
                  TextSpan(
                    // text:dd,
                    text: user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
