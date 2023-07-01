// ignore_for_file: use_build_context_synchronousl, non_constant_identifier_names
import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shoping/app/models/orders.dart';
import 'package:shoping/app/models/prodect.dart';
import 'package:shoping/app/models/sales.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/components/decortion.dart';
import 'package:shoping/components/error_handling.dart';
import 'package:shoping/components/utils.dart';

class Adminservice {
  // ignore: non_constant_identifier_names
  void SaveProdect({
    required BuildContext context,
    required String name,
    required String description,
    required String category,
    required String price,
    required String qty,
    required List<File> images,
  }) async {
    // ignore: non_constant_identifier_names
    final UserProviders = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloud = CloudinaryPublic('dbohe6wph','rycyeyji');
      List<String> imageUrl = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloud.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: category));
        imageUrl.add(res.secureUrl);
      }
      Prodect prodect = Prodect(
        name: name,
        description: description,
        category: category,
        price: int.parse(price),
        qty: int.parse(qty),
        images: imageUrl,
      );

      http.Response response = await http.post(
        Uri.parse('$myUri01/admin/add-prodect'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'My-shopping-Auth-token': UserProviders.user.token
        },
        body: prodect.toJson(),
      );print(prodect.toJson(),);
      // ignore: use_build_context_synchronously
      httpErrorHandel(
          response: response,
          context: context,
          onSuccess: () {
            showSnakBar(context, 'added');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  Future<List<Prodect>> getAllProdects(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Prodect> prodectList = [];
    try {

      var uri=Uri.parse('$myUri01/admin/get-prodect');
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


  void deletProdect({
    required BuildContext context,
    required Prodect prodect,
    required VoidCallback sussec
  })
  async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    var uri=Uri.parse('$myUri01/admin/delet-prodect');
    try {
      http.Response res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
          'My-shopping-Auth-token': userProvider.user.token,
        },
        body:jsonEncode({
        'id':prodect.id
      })
      );
      print(jsonEncode(jsonDecode(res.body),));
      // ignore: use_build_context_synchronously
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            sussec();
          });
    } catch (e) {
      showSnakBar(context, e.toString());
      print(e.toString());

    }
  }
  void ChangOrderState({
    required BuildContext context,
    required int  status,required Order order,
    required VoidCallback sussec
  })
  async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    var uri=Uri.parse('$myUri01/admin/update-order');
    try {
      http.Response res = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Charset': 'utf-8',
            'My-shopping-Auth-token': userProvider.user.token,
          },
          body:jsonEncode({

            'id':order.id,
            'status':status,
          })
      );
      print(jsonEncode(jsonDecode(res.body),));
      // ignore: use_build_context_synchronously
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            sussec();
          });
    } catch (e) {
      showSnakBar(context, e.toString());
      print(e.toString());

    }
  }

  Future<List<Order>> getAllMyOrder({
    required BuildContext context,

  }) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> ordertList = [];
    try {

      var uri=Uri.parse('$myUri01/api/all-order-admin');
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

  Future<Map<String,dynamic>> getTotalSales(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    double totalSales=0;
    double totalOrders=0;
    double totalProdect=0;
    try {

      var uri=Uri.parse('$myUri01/admin/analytics');
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
         var result=jsonDecode(res.body);
         totalSales=Decortion.checkDouble(result['totalSales']?? 0.0) ;
         totalOrders=Decortion.checkDouble(result['totalOrders']?? 0.0) ;
         totalProdect=Decortion.checkDouble(result['totalProdect']?? 0.0) ;

         sales=[


           Sales(lable: 'catMobil', totalSales: Decortion.checkDouble(result['catMobil']?? 0.0)),
           Sales(lable: 'catiPad', totalSales:Decortion.checkDouble (result['catiPad'] ?? 0.0)),
           Sales(lable: 'catcomputer', totalSales:Decortion.checkDouble(result['catcomputer']?? 0.0)),
           Sales(lable: 'catkeyboard', totalSales: Decortion.checkDouble(result['catkeyboard']?? 0.0)),
           Sales(lable: 'catStory', totalSales: Decortion.checkDouble(result['catStory']?? 0.0)),

         ];
          }
      );

    } catch (e) {
      showSnakBar(context, e.toString());
      print(e.toString());

    }
    return {
      'sales':sales,
      'totalSales':totalSales,
      'totalOrders':totalOrders,
      'totalProdect':totalProdect,

    };
  }
}
