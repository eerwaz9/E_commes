// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/models/prodect.dart';
import 'package:shoping/app/models/user.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shoping/components/error_handling.dart';
import 'package:shoping/components/utils.dart';
import '../../components/decortion.dart';

class ProdectServices {
  void rateProdect({
    required BuildContext context,
    required Prodect prodect,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse('$myUri01/api/rate-prodect'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Charset': 'utf-8',
            'My-shopping-Auth-token': userProvider.user.token,
          },body: jsonEncode({
                'id': prodect.id,
        'rating':rating
              }));
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: (){
showSnakBar(context, 'prodect has been rated successively');
          });
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  void AddProdectToCart({
    required BuildContext context,
    required Prodect prodect,
    required dynamic qty,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {http.Response res;

if(qty<0){
  res = await http.delete(
      Uri.parse('$myUri01/api/remove-to-card/${prodect.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'My-shopping-Auth-token': userProvider.user.token,
      },
    );
}else{
  res = await http.post(
      Uri.parse('$myUri01/api/add-to-card'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'My-shopping-Auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'id': prodect.id!,
        'qty':qty,
      }));
}

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: (){
            User user=userProvider.user.copyWith(
              cart:jsonDecode(res.body)['cart'],
            );userProvider.serObjectUser(user);

            if(qty>0){showSnakBar(context, 'prodect has been add successful');
            Navigator.pop(context);}

          });
    } catch (e) {
      showSnakBar(context, e.toString());
      print(e.toString());
    }
  }


  void saveUserAddress({required BuildContext context, required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse('$myUri01/api/save-address'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Charset': 'utf-8',
            'My-shopping-Auth-token': userProvider.user.token,
          },body: jsonEncode({
      'address':address,
      }));
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: (){
            User user=userProvider.user.copyWith(
              address:jsonDecode(res.body)['address'],);

            userProvider.serObjectUser(user);


            showSnakBar(context, 'prodect has been rated update');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnakBar(context, e.toString());

    }
  }


  void setAnOrder({
    required BuildContext context,
    required double totalPrice,
    required String address,
    required String paymentMethods,
  }) async {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse('$myUri01/api/order'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Charset': 'utf-8',
            'My-shopping-Auth-token': userProvider.user.token,
          },
          body: jsonEncode({
        'cart':userProvider.user.cart,
        'totalPrice':totalPrice,
        'address':address,
       'paymentMethods':paymentMethods,
      }),);
      httpErrorHandel(response: res, context: context, onSuccess: (){
            User user=userProvider.user.copyWith(
            cart: [],);

            userProvider.serObjectUser(user);
            showSnakBar(context, 'Order sent Successfully');
           Navigator.pop(context);
          });
    } catch (e) {
      showSnakBar(context, e.toString());


    }
  }
}
