import 'package:flutter/material.dart';
import 'package:shoping/app/models/orders.dart';
import 'package:shoping/app/screens/order_detailes_screen.dart';
import 'package:shoping/app/services/home_service.dart';
import 'package:shoping/components/utils.dart';
import '';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

// List list = [
//   'https://envato-shoebox-0.imgix.net/b653/b7f1-f047-43a5-a405-f36350353801/MON1217181.jpg?auto=compress%2Cformat&fit=max&mark=https%3A%2F%2Felements-assets.envato.com%2Fstatic%2Fwatermark2.png&markalign=center%2Cmiddle&markalpha=18&w=400&s=195f193a126f2d6bc5036037feae3d7a',
//   'https://envato-shoebox-0.imgix.net/8018/9f45-acd7-4371-967a-272df163fe5a/DSCF7864.jpg?auto=compress%2Cformat&fit=max&mark=https%3A%2F%2Felements-assets.envato.com%2Fstatic%2Fwatermark2.png&markalign=center%2Cmiddle&markalpha=18&w=800&s=143adfca3a7fc6086f7937ab4f83bc0d',
//   'https://elements-cover-images-0.imgix.net/ebbd595e-0b0a-4225-88b4-86114454d130?auto=compress%2Cformat&fit=max&w=1170&s=16008ed7d208e1d84e0b928e8ca611d8',
//   'https://elements-cover-images-0.imgix.net/0cef585e-7cbe-4889-a64b-61b1acbd5426?auto=compress%2Cformat&fit=max&w=1170&s=28df2860d506d07d5096b2b496193e42',
//   'https://elements-cover-images-0.imgix.net/d071fa8d-4838-4323-9417-d2d2f5c82b50?auto=compress%2Cformat&fit=max&w=1170&s=b3a46f181dc4a0d8a272e59d78e087e3',
// ];
String dd='https://elements-cover-images-0.imgix.net/d071fa8d-4838-4323-9417-d2d2f5c82b50?auto=compress%2Cformat&fit=max&w=1170&s=b3a46f181dc4a0d8a272e59d78e087e3';
class _OrdersState extends State<Orders> {
  List<Order>? orders;
  HomeService homeService = HomeService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getAllUserOrder();
  }

  getAllUserOrder() async {
    orders = await homeService.getMyOrder(context: context);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Orders',
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ],
          ),
          const Divider(
            thickness: .5,
            color: Colors.grey,
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: .5),
                  ),
                ),
                children: [
                  tableHeader('Order'),
                  tableHeader('Amount'),
                  tableHeader('Status'),
                  tableHeader('0'),
                ],
              ),
              if (orders != null)
                for (int i = 0; i < orders!.length; i++)
                  tableRow(context,
                      image: orders![i].prodects[0].images[0],
                      amount: orders![i].totalPrice.toString(),
                      status: orders![i].status,
                      index: (i + 1).toString(),i:i),
            ],
          ),
        ],
      ),
    );
  }

  TableRow tableRow(context, {index, image, amount,required int status,required int i}) {
    return TableRow(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: .5),
          ),
        ),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.network(
                    image,
                    width: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(index.toString()),
              ],
            ),
          ),
          Text(amount),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getStatusColor(status),
                ),
                height: 10,
                width: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(getstatus(status)),
            ],
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context,
                  OrderDetailesScreen.routeName,
                  arguments: orders![i]);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: const Center(
                child: Text(
                  "view",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
