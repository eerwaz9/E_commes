import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/models/prodect.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/app/services/prodect_services.dart';

class ProdectCatCat extends StatefulWidget {
  const ProdectCatCat({Key? key,required this.index}) : super(key: key);

final int index;

  @override
  State<ProdectCatCat> createState() => _ProdectCatCatState();
}

class _ProdectCatCatState extends State<ProdectCatCat> {
  final ProdectServices prodectServices=ProdectServices();
  void increaseQty(Prodect prodect){
prodectServices.AddProdectToCart(context: context, prodect: prodect, qty: 1);
  }
  void decreaseQty(Prodect prodect){
    prodectServices.AddProdectToCart(context: context, prodect: prodect, qty: -1);
  }
  @override
  Widget build(BuildContext context) {
    final prodeCtcart = context.watch<UserProvider>().user.cart[widget.index];
    final prodect = Prodect.fromMap(prodeCtcart['prodect']);
    final qty = prodeCtcart['qty'];
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                prodect.images[0],
                height: 135,
                width: 135,
                fit: BoxFit.contain,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      prodect.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${prodect.price}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'for Free shoping',
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'In stock',
                      style: TextStyle(color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {decreaseQty(prodect);},
                      child: Container(
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 10,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(qty.toString()),
                      ),
                    ),
                    InkWell(
                      onTap: () {increaseQty(prodect);},
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
