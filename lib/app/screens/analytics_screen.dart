// ignore_for_file: non_constant_identifier_names

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:shoping/app/models/sales.dart';
import 'package:shoping/app/services/admin_service.dart';
import 'package:shoping/app/widgets/analytics_charts.dart';
import 'package:shoping/app/widgets/loader.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}
class _AnalyticsScreenState extends State<AnalyticsScreen> {
  Adminservice adminservice=Adminservice();
  List<Sales>? sales;
  double? totalSales;
  double? totalProdect;
  double? totalOrders;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnalitci();
  }
  void getAnalitci()async{
var dataSales=await adminservice.getTotalSales(context);
totalSales=dataSales['totalSales'];
totalProdect=dataSales['totalProdect'];
totalOrders=dataSales['totalOrders'];
sales=dataSales['sales'];
setState(() {

});
  }
  @override
  Widget build(BuildContext context) {
    return sales==null ?const Loader():
    Column(
      children: [Text('\$$totalSales',
        style: const TextStyle(fontSize: 20),
      ),
        SizedBox(
          height: 250,
          child: AnalyticsChrts(
            seriesList: [
              charts.Series(id: 'Sales', data: sales!, domainFn: (Sales MySales,_){
                return MySales.lable;
              }, measureFn: (Sales MySales,_){
                return MySales.totalSales;
              },)
            ],
          ),
        )
      ],
    );
  }
}
