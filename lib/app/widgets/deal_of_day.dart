import 'package:flutter/material.dart';
import 'package:shoping/app/models/prodect.dart';
import 'package:shoping/app/screens/prodect_details_screen.dart';
import 'package:shoping/app/widgets/loader.dart';
import 'package:shoping/app/widgets/prodect_card_horizonatl.dart';

import '../services/home_service.dart';

class DealfoDay extends StatefulWidget {
  const DealfoDay({
    Key? key,
  }) : super(key: key);
  @override
  State<DealfoDay> createState() => _DealfoDayState();
}

class _DealfoDayState extends State<DealfoDay> {
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
    ListProdect = await homeService.dealofProdects(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names

    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: const Text(
              "deal the day",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),

        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: ListProdect == null
              ? const Loader()
              : ListView.builder(
            scrollDirection: Axis.vertical,
                  itemCount: ListProdect!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProdectDetails.routeName,
                            arguments: ListProdect![index]);
                      },
                      child: ProdectCardhorizinatls(
                        prodect: ListProdect![index],
                      ),
                    );
                  }),
        )
      ],
    );
  }
}
