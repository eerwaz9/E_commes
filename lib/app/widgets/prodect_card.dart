import 'package:flutter/material.dart';

import '../models/prodect.dart';

class Prodectcard extends StatelessWidget {
  const Prodectcard({Key? key, required this.prodect, required this.isLike})
      : super(key: key);
  final Prodect prodect;
  final bool isLike;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black12, blurRadius: 15, spreadRadius: 10)
          ]),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.amberAccent,
                      ),
                      Image.network(prodect.images[0]),
                    ],
                  ),
                ),
                Text(
                  prodect.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Best seal',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                Text(
                  '${prodect.price} \$',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
            Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                  onPressed: () {

                  },
                  icon: Icon(
                    isLike ? Icons.favorite : Icons.favorite_border,
                    color: isLike ? Colors.white : Colors.red,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
