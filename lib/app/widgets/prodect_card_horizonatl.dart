import 'package:flutter/material.dart';
import 'package:shoping/app/models/prodect.dart';
import 'package:shoping/app/widgets/stars_bar.dart';

class ProdectCardhorizinatls extends StatelessWidget {
  const ProdectCardhorizinatls({Key? key, required this.prodect})
      : super(key: key);
  static const routeName="/prodect-horizontal";
  final Prodect prodect;


  @override
  Widget build(BuildContext context) {
    double avgRating=0;
    double totalRating=0;
    for(int i=0;i<prodect.rating!.length;i++){
      totalRating+=(prodect.rating![i].rating);}
    if(totalRating > 0){
      avgRating=(totalRating / prodect.rating!.length);
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
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
                      style: const TextStyle(fontSize: 17),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10,top:5),
               child:  StarsBar(rating: avgRating ,),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10,top: 5),
                    child: Text(
                      '\$${prodect.price}',
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Eligible for FREE Shoping',
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10,top: 5),
                    child: const Text(
                      'In Stock',style: TextStyle(color: Colors.teal,),maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
