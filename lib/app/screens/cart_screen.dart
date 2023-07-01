import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/app/screens/address_screen.dart';
import 'package:shoping/app/widgets/address_bar.dart';
import 'package:shoping/app/widgets/cart_subtotal.dart';
import 'package:shoping/app/widgets/custem_butten.dart';
import 'package:shoping/app/widgets/prodect_cart_cart.dart';
import 'package:shoping/components/decortion.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['qty'] * e['prodect']['price'] as int)
        .toList();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Decortion.appBarGradent,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Center(
              child: Text(
                'card screen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBar(),
            const CartSubTotal(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Custembutten(text:'Proceed to Buy (${user.cart.length})' , onTap: () {
                    Navigator.pushNamed(context, AddressScreen.routeName,arguments: sum.toString());},
              )

            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProdectCatCat(index: index);
                })
          ],
        ),
      ),
    );
  }
}
