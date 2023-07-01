// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/models/orders.dart';
import 'package:shoping/app/models/prodect.dart';
import 'package:shoping/components/decortion.dart';
import 'package:http/http.dart' as http;
import 'package:shoping/components/error_handling.dart';
import 'package:shoping/components/utils.dart';
import '../providers/user_provider.dart';

class HomeService{
  Future<List<Prodect>> getCategoryProdects({
required BuildContext context,
    required String category,
}) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Prodect> prodectList = [];
    try {

      var uri=Uri.parse('$myUri01/api/get-prodect?category=$category');
      http.Response res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
          'My-shopping-Auth-token': userProvider.user.token,
        },
      );
      print(jsonEncode(jsonDecode(res.body),));
      // ignore: use_build_context_synchronously
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            for(var i=0;i < jsonDecode(res.body).length;i++){
              prodectList.add(Prodect.fromJson((jsonEncode(jsonDecode(res.body)[i]))
              )
              );
            }
          }
      );
      return prodectList;
    } catch (e) {
      showSnakBar(context, e.toString());
      print(e.toString());

    }
    return prodectList;
  }

  Future<List<Prodect>> SearchProdects({
    required BuildContext context,
    required String txt,
  }) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Prodect> prodectList = [];
    try {

      var uri=Uri.parse('$myUri01/api/get-prodect/search/$txt');
      http.Response res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
          'My-shopping-Auth-token': userProvider.user.token,
        },
      );
      print(jsonEncode(jsonDecode(res.body),));
      // ignore: use_build_context_synchronously
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            for(var i=0;i < jsonDecode(res.body).length;i++){
              prodectList.add(Prodect.fromJson((jsonEncode(jsonDecode(res.body)[i]))
              )
              );
            }
          }
      );
      return prodectList;
    } catch (e) {
      showSnakBar(context, e.toString());
      print(e.toString());

    }
    return prodectList;
  }
  Future<List<Prodect>> dealofProdects({
    required BuildContext context,

  }) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Prodect> prodectList = [];
    try {

      var uri=Uri.parse('$myUri01/api/deal-of-day');
      http.Response res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
          'My-shopping-Auth-token': userProvider.user.token,
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            for(var i=0;i < jsonDecode(res.body).length;i++){
              prodectList.add(Prodect.fromJson((jsonEncode(jsonDecode(res.body)[i]))
              )
              );
            }
          }
      );
      return prodectList;
    } catch (e) {
      showSnakBar(context, e.toString());
      print(e.toString());

    }
    return prodectList;
  }
  Future<List<Order>> getMyOrder({
    required BuildContext context,

  }) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> ordertList = [];
    try {

      var uri=Uri.parse('$myUri01/api/my-order');
      http.Response res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
          'My-shopping-Auth-token': userProvider.user.token,
        },
      );
      // ignore: use_build_context_synchronously
      print(jsonEncode(jsonDecode(res.body)));
      // ignore: use_build_context_synchronously
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            for(var i=0;i < jsonDecode(res.body).length;i++){
              ordertList.add(
                  Order.fromJson((jsonEncode(jsonDecode(res.body)[i]))
              )
              );
            }


          }
      );
      return ordertList;
    } catch (e) {
      showSnakBar(context, e.toString());
      print(e.toString());

    }
    return ordertList;
  }
}