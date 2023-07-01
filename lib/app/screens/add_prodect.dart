// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/app/services/admin_service.dart';
import 'package:shoping/app/widgets/custem_butten.dart';
import 'package:shoping/app/widgets/custem_widget.dart';

import '../../components/decortion.dart';
import '../../components/utils.dart';

class AddProdect extends StatefulWidget {
  const AddProdect({Key? key}) : super(key: key);
  static const String routeName = '/addProduct';
  @override
  State<AddProdect> createState() => _AddProdectState();
}

class _AddProdectState extends State<AddProdect> {
  final Adminservice AdminServics = Adminservice();
  final _Addprodectform = GlobalKey<FormState>();
  List<File> images = [];
  TextEditingController nameprodect = TextEditingController();
  TextEditingController decprodect = TextEditingController();
  TextEditingController priceprodect = TextEditingController();
  TextEditingController qtyprodect = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameprodect.dispose();
    decprodect.dispose();
    priceprodect.dispose();
    qtyprodect.dispose();
  }

  void pickAnImage() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void AddProdect() {
    if (_Addprodectform.currentState!.validate() && images.isNotEmpty) ;
    AdminServics.SaveProdect(
        context: context,
        name: nameprodect.text,
        description: decprodect.text,
        category: catogery,
        price: priceprodect.text,
        qty: qtyprodect.text,
        images: images);
    Navigator.pop(context);
  }

  String catogery = "Mobil";
  @override
  Widget build(BuildContext context) {
    final uesr=Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Decortion.appBarGradent,
          ),
        ),
        title: const Text("add prodect"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _Addprodectform,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map((e) {
                            return Builder(
                                builder: (BuildContext context) => Image.file(
                                      e,
                                      fit: BoxFit.cover,
                                      height: 20,
                                    ));
                          }).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        )
                      : GestureDetector(
                          onTap: pickAnImage,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(20),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "select prodect image",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustemText(
                    controller: nameprodect,
                    lable: 'nameprodect',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustemText(
                    controller: decprodect,
                    lable: uesr.type,
                    maxLains: 4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustemText(
                    controller: priceprodect,
                    lable: 'priceprodect',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustemText(
                    controller: qtyprodect,
                    lable: 'qtyprodect',
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: catogery,
                      icon:  Icon(Icons.keyboard_arrow_down),
                      items: Decortion.categories.map((e) {
                        return DropdownMenuItem(
                            value: e['title']!, child: Text(e['title']!));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          catogery = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Custembutten(text: "Save", onTap: AddProdect),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
