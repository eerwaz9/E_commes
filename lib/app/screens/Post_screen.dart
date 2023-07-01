import 'package:flutter/material.dart';
import 'package:shoping/app/models/prodect.dart';
import 'package:shoping/app/screens/add_prodect.dart';
import 'package:shoping/app/services/admin_service.dart';
import 'package:shoping/app/widgets/loader.dart';
import 'package:shoping/app/widgets/single_prodect.dart';

import '../../components/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // List list = [
  //   'https://envato-shoebox-0.imgix.net/b653/b7f1-f047-43a5-a405-f36350353801/MON1217181.jpg?auto=compress%2Cformat&fit=max&mark=https%3A%2F%2Felements-assets.envato.com%2Fstatic%2Fwatermark2.png&markalign=center%2Cmiddle&markalpha=18&w=400&s=195f193a126f2d6bc5036037feae3d7a',
  //   'https://envato-shoebox-0.imgix.net/8018/9f45-acd7-4371-967a-272df163fe5a/DSCF7864.jpg?auto=compress%2Cformat&fit=max&mark=https%3A%2F%2Felements-assets.envato.com%2Fstatic%2Fwatermark2.png&markalign=center%2Cmiddle&markalpha=18&w=800&s=143adfca3a7fc6086f7937ab4f83bc0d',
  //   'https://elements-cover-images-0.imgix.net/ebbd595e-0b0a-4225-88b4-86114454d130?auto=compress%2Cformat&fit=max&w=1170&s=16008ed7d208e1d84e0b928e8ca611d8',
  //   'https://elements-cover-images-0.imgix.net/0cef585e-7cbe-4889-a64b-61b1acbd5426?auto=compress%2Cformat&fit=max&w=1170&s=28df2860d506d07d5096b2b496193e42',
  //   'https://elements-cover-images-0.imgix.net/d071fa8d-4838-4323-9417-d2d2f5c82b50?auto=compress%2Cformat&fit=max&w=1170&s=b3a46f181dc4a0d8a272e59d78e087e3',
  // ];

  final Adminservice adminservice = Adminservice();
  List<Prodect>? prodects;

  @override
  void initState() {
    super.initState();
    getAllProdects();
  }

  void getAllProdects() async {
    prodects = await adminservice.getAllProdects(context);
    setState(() {});
  }

  void deletProdect(Prodect prodect, int index) async {
    adminservice.deletProdect(
        context: context,
        prodect: prodect,
        sussec: () {
          prodects!.removeAt(index);
        });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return prodects == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
                itemCount: prodects!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final theProdect = prodects![index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: SingleProdect(
                            image: theProdect.images[0],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  theProdect.name,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  showAlertDialog(context, () {
                                    deletProdect(theProdect, index);
                                    Navigator.pop(context);
                                  }, 'Delete Prodect', 'Are You Soure');
                                },
                                icon: Icon(Icons.delete_outline))
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddProdect.routeName);
                },
                tooltip: ' theProdect.name',
                child: const Icon(Icons.add)),
          );
  }
}
