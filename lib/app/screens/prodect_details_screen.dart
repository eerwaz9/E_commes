import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/app/services/prodect_services.dart';
import 'package:shoping/app/widgets/stars_bar.dart';
import 'package:shoping/components/decortion.dart';

import '../models/prodect.dart';

class ProdectDetails extends StatefulWidget {
  const ProdectDetails({Key? key, required this.prodect}) : super(key: key);
  static const String routeName = "/prodect-screen";
  final Prodect prodect;
  @override
  State<ProdectDetails> createState() => _ProdectDetailsState();
}

class _ProdectDetailsState extends State<ProdectDetails> {
  ProdectServices prodectServices = ProdectServices();
  double avgRating=0;
  double userRating=0;
  @override
  void initState() {
    super.initState();
    double totalRating=0;

    var user=Provider.of<UserProvider>(context,listen: false).user;
    for(int i=0;i<widget.prodect.rating!.length;i++){
      totalRating+=(widget.prodect.rating![i].rating);
      if(widget.prodect.rating![i].userId==user.Id){
         userRating=widget.prodect.rating![i].rating;

      }
    }
if(totalRating > 0){
  avgRating=(totalRating / widget.prodect.rating!.length);
}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Decortion.appBarGradent,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detail for ${widget.prodect.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.prodect.id!),
                   StarsBar(rating: avgRating),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                widget.prodect.name,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            CarouselSlider(
              items: widget.prodect.images.map((i) {
                return Builder(
                    builder: (BuildContext context) => Image.network(
                          i,
                          fit: BoxFit.contain,
                          height: 200,
                        ));
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: 'Deal price',
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: '\$${widget.prodect.price}',
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.red,
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(widget.prodect.description),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                "Rale The Prodect",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
initialRating: avgRating,
// initialRating: userRating,

                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),


                itemBuilder: (context, _) {
              return const Icon(Icons.star, color: Colors.amber);
            }, onRatingUpdate: (rating) {
              prodectServices.rateProdect(
                  context: context, prodect: widget.prodect, rating: rating);
            }),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.deepPurpleAccent,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56, 56),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () {},
        onClose: () {},
        elevation: 8.0,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.shopping_cart_outlined),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: "Add to Card",
            labelStyle: const TextStyle(fontSize: 18),
            onTap: () {
              prodectServices.AddProdectToCart(
                  context: context,
                  prodect:widget.prodect,
                  qty: 1);
              // Navigator.pop(context);
              },
          ),
          SpeedDialChild(
            child: const Icon(Icons.monetization_on_outlined),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: "Buy Now",
            labelStyle: const TextStyle(fontSize: 18),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
