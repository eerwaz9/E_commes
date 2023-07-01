import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/models/orders.dart';
import 'package:shoping/app/services/admin_service.dart';
import 'package:shoping/app/widgets/custem_butten.dart';
import 'package:shoping/components/decortion.dart';

import '../providers/user_provider.dart';

class OrderDetailesScreen extends StatefulWidget {
  const OrderDetailesScreen({Key? key, required this.order}) : super(key: key);
  static const routeName = "/order";
  final Order order;
  @override
  State<OrderDetailesScreen> createState() => _OrderDetailesScreenState();
}

class _OrderDetailesScreenState extends State<OrderDetailesScreen> {
  int currentState = 0;
  Adminservice adminservice=Adminservice();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentState = widget.order.status;
  }
  void updateOrder(int status,Order order){
adminservice.ChangOrderState(context: context, status: status+1, order: order, sussec: (){
setState(() {
  currentState+=1;
});
});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Decortion.appBarGradent,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Order Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'data',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "data :${DateTime.fromMicrosecondsSinceEpoch(widget.order.orderedAt)}"),
                    Text("ID :${widget.order.id}"),
                    Text("Total : \$${widget.order.totalPrice}"),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'prodect',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.prodects.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.network(
                              widget.order.prodects[i].images[0],
                              width: 120,
                              height: 120,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.order.prodects[i].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                      'Qty :${widget.order.prodects[i].selQty}')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Tracking Order',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Stepper(
                        currentStep: currentState,
                        controlsBuilder: (context, details) {
                          if (user.type == "admin") {
                            return Custembutten(
                              text: "Done",
                              onTap: () {
                                updateOrder(details.currentStep,widget.order);
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                        steps: [
                          Step(
                            title: const Text("pending"),
                            content: const Text("we Jost yours Order"),
                            isActive: currentState == 0,
                            state: currentState > 0
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: const Text("preparing"),
                            content:
                                const Text("your order is ready to shaping"),
                            isActive: currentState == 1,
                            state: currentState > 1
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: const Text("Ready"),
                            content: const Text("yor Order ready to shoping"),
                            isActive: currentState == 2,
                            state: currentState > 2
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: const Text("On way"),
                            content: const Text("Order is on the way"),
                            isActive: currentState == 3,
                            state: currentState > 3
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: const Text("Completed"),
                            content: const Text("Have Fun with your Order"),
                            isActive: currentState == 4,
                            state: currentState >= 4
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
