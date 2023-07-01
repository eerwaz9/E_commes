import 'package:flutter/material.dart';
import 'package:shoping/app/models/orders.dart';
import 'package:shoping/app/screens/order_detailes_screen.dart';
import 'package:shoping/app/services/admin_service.dart';
import 'package:shoping/app/widgets/loader.dart';
import 'package:shoping/components/utils.dart';
class AdminorderScreen extends StatefulWidget {
  const AdminorderScreen({Key? key}) : super(key: key);

  @override
  State<AdminorderScreen> createState() => _AdminorderScreenState();
}

class _AdminorderScreenState extends State<AdminorderScreen> {

  List<Order>? orders;
  Adminservice adminservice = Adminservice();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllAdminOrder();
  }
  getAllAdminOrder() async {
    orders = await adminservice.getAllMyOrder(context: context);
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
         orders == null ? const Loader() : Table(
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
