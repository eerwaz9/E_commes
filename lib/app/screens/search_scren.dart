// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shoping/app/models/prodect.dart';
import 'package:shoping/app/screens/prodect_details_screen.dart';
import 'package:shoping/app/services/home_service.dart';
import 'package:shoping/app/widgets/loader.dart';
import 'package:shoping/app/widgets/prodect_card.dart';

import 'package:shoping/components/decortion.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.searchtxt}) : super(key: key);
  static const String routeName = "/search-screen";
  final String searchtxt;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Prodect>? ListProdect;
  HomeService homeService = HomeService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fechCategories();
  }

  fechCategories() async {
    ListProdect = await homeService.SearchProdects(
        context: context, txt: widget.searchtxt);
    setState(() {});
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
              'search result for ${widget.searchtxt}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      // ignore: unnecessary_null_comparison
      body: ListProdect == null
          ? const Loader()
          : GridView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: ListProdect!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final prodect = ListProdect![index];
                return GestureDetector(

                    onTap: (){
                      Navigator.pushNamed(context, ProdectDetails.routeName,arguments: ListProdect![index]);
                    },
                    child: Prodectcard(isLike: false,prodect: prodect));
                //   Column(
                //   children: [
                //     SizedBox(
                //       height: 140,
                //       child: SizedBox(
                //         child: SingleProdect(
                //           image: prodect.images[0],
                //         ),
                //       ),
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Expanded(
                //           child: Padding(
                //             padding: const EdgeInsets.only(left: 12),
                //             child: Text(
                //               prodect.name,
                //               style:
                //                const  TextStyle(fontSize: 16, color: Colors.black),
                //               overflow: TextOverflow.ellipsis,
                //               maxLines: 2,
                //             ),
                //           ),
                //         ),
                //         Text(
                //           '${prodect.price} Real',
                //           style: TextStyle(fontWeight: FontWeight.bold),
                //         )
                //       ],
                //     ),
                //   ],
                // );
              }),
    );
  }
}
