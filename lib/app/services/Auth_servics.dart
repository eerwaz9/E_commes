import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping/app/models/user.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/app/screens/Auth_screen.dart';
import 'package:shoping/app/widgets/animait_add_abar.dart';
import 'package:shoping/components/decortion.dart';
import 'package:shoping/components/error_handling.dart';
import 'package:shoping/components/utils.dart';

import '../widgets/custem_butten_bar.dart';

class Authservics {
  void signUpUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user = User.getNewEmpty();
      http.Response res = await http.post(
        Uri.parse("$myUri01/api/signup"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8'
        },
        body: user.toJson(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            showSnakBar(context, "تم انشاء الحساب وقمت بتسجيل الدخول");
          });
    } catch (err) {
      showSnakBar(context, err.toString());
    }
  }
  void signinUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse("$myUri01/api/signin"),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=utf-8'
          });
      // ignore: use_build_context_synchronously
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences shared = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await shared.setString(
                "My-shopping-Auth-token", jsonDecode(res.body)['token']);
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
                context, BottomNavBar.routeName, (route) => false);
            //  showSnakBar(context, "تم تسجيل الدخول");
          });
    } catch (err) {
      showSnakBar(context, err.toString());
    }
  }

  Future<void> getUserdata(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('My-shopping-Auth-token');

      if (token == null) {
      await  prefs.setString('My-shopping-Auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$myUri01/isValidToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'My-shopping-Auth-token': token!
        },
      );
      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$myUri01/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'My-shopping-Auth-token': token
          },
        );
        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
        //get user data
      }
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  void LougUot(BuildContext context)async{
    try{
      SharedPreferences shared = await SharedPreferences.getInstance();
      await shared.setString('My-shopping-Auth-token','');
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routName, (route) => false);
    }catch(e){

      showSnakBar(context, e.toString());
    }
  }
}
