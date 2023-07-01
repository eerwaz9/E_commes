import 'package:flutter/material.dart';
import 'package:shoping/app/screens/category_deal-screen.dart';
import 'package:shoping/components/decortion.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);
void toCategoryPage(BuildContext context,String category){
  Navigator.pushNamed(context, CategoryDealScreen.routName,arguments: category);
}
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 75,
          itemCount: Decortion.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                toCategoryPage(context, Decortion.categories[index]["title"]!);
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      Decortion.categories[index]["image"]!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    Decortion.categories[index]["title"]!,
                  )
                ],
              ),
            );
          }),
    );
  }
}
