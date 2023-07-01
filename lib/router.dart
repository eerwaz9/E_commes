import 'package:flutter/material.dart';
import 'package:shoping/app/models/orders.dart';
import 'package:shoping/app/models/prodect.dart';
import 'package:shoping/app/screens/Auth_screen.dart';
import 'package:shoping/app/screens/add_prodect.dart';
import 'package:shoping/app/screens/address_screen.dart';
import 'package:shoping/app/screens/admin_screen.dart';
import 'package:shoping/app/screens/home_screen.dart';
import 'package:shoping/app/screens/order_detailes_screen.dart';
import 'package:shoping/app/screens/prodect_details_screen.dart';
import 'app/screens/category_deal-screen.dart';
import 'app/screens/search_scren.dart';
import 'app/widgets/animait_add_abar.dart';
import 'app/widgets/custem_butten_bar.dart';
Route<dynamic> generatRoute (RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>   const AuthScreen()
      );
    case AdminScreen.routName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>   AdminScreen()
      );
    case homeScreen.routName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>   homeScreen()
      );
      case BottomBar.routeName:
    return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>   BottomBar()
    );
    case AddressScreen.routeName:
      var totalAmunt=routeSettings.arguments as String;
    return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>   AddressScreen(TotalAmunt:totalAmunt ,)
    );
    case AddProdect.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>   AddProdect()
      );
      case ProdectDetails.routeName:
        var prodect=routeSettings.arguments as Prodect;
    return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>   ProdectDetails(prodect: prodect,)
    );
    case BottomNavBar.routeName:
    return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>   BottomNavBar()
    );
    case AdminScreen.routeName:
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_)=>   const AdminScreen());

      case SearchScreen.routeName:
        var txt=routeSettings.arguments as String;
    return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>    SearchScreen( searchtxt: txt,),
    );

    case OrderDetailesScreen.routeName:
    var order=routeSettings.arguments as Order;
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_)=>    OrderDetailesScreen( order: order,),
    );
      case CategoryDealScreen.routName:
        var category=routeSettings.arguments as String;
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>   CategoryDealScreen(
            category: category,
          ),
        );

      default:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_)=>  Scaffold(
              body: Center(child: Text("no any thng"),),
            )
        );
  }
}