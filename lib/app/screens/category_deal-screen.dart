import 'package:flutter/material.dart';
import 'package:shoping/app/models/prodect.dart';
import 'package:shoping/app/services/home_service.dart';
import 'package:shoping/app/widgets/loader.dart';
import 'package:shoping/app/widgets/single_prodect.dart';

import '../../components/decortion.dart';

class CategoryDealScreen extends StatefulWidget {
  const CategoryDealScreen({Key? key, required this.category})
      : super(key: key);
  final String category;
  static const String routName = '/category-screen';
  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  // ignore: non_constant_identifier_names
  List<Prodect>? ListProdect;
  HomeService homeService = HomeService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fechCategories();
  }

  fechCategories() async {
    ListProdect = await homeService.getCategoryProdects(
        context: context, category: widget.category);
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
              widget.category,
              style:const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      // ignore: unnecessary_null_comparison
      body: ListProdect == null
          ? const Loader()
          :  GridView.builder(
                  padding:const EdgeInsets.only(top: 10),
                  itemCount: ListProdect!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,),
                  itemBuilder: (context, index) {
                    final prodect = ListProdect![index];
                    return Container(
                      decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.black12, blurRadius: 15, spreadRadius: 10)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 140,
                            child: SizedBox(
                              child: SingleProdect(
                                image: prodect.images[0],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    prodect.name,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              Text(
                                '${prodect.price} Real ',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),


    );
  }
}
