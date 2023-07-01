// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/json/json.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/app/services/prodect_services.dart';
import 'package:shoping/app/widgets/custem_butten.dart';
import 'package:shoping/app/widgets/custem_widget.dart';
import 'package:shoping/components/decortion.dart';
import 'package:shoping/components/utils.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key, required this.TotalAmunt}) : super(key: key);
  static const routeName = '/address-screen';
  final String TotalAmunt;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final ProdectServices prodectServices = ProdectServices();
  final TextEditingController addressTxt = TextEditingController();
  final TextEditingController hometxt = TextEditingController();
  final TextEditingController areatxt = TextEditingController();
  final TextEditingController specialtxt = TextEditingController();
  final _AddressFormScreen = GlobalKey<FormState>();
  final List<PaymentItem> _paymentItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentItems.add(
        PaymentItem(
        label: 'Total',
        amount: widget.TotalAmunt,
        status: PaymentItemStatus.final_price),
    );
  }

  void payPressed(String theAddress, String paymentMethods) {
    bool formok =
        addressTxt.text.isNotEmpty ||
        hometxt.text.isNotEmpty ||
        areatxt.text.isNotEmpty ||
        specialtxt.text.isNotEmpty;
    if (formok) {
      if (_AddressFormScreen.currentState!.validate()) {
        theAddress = "${addressTxt.text},${hometxt.text},${areatxt.text},${specialtxt.text},";
      } else {
        showAlertDialog2(context, 'Stop', 'Fill in address information');
      }
    } else {
      if(theAddress.isEmpty){
        showAlertDialog2(context, 'Stop', 'Fill in address information11');
      }

    }
    prodectServices.saveUserAddress(context: context,
        address: theAddress);
    prodectServices.setAnOrder(
        context: context,
        totalPrice: double.parse(widget.TotalAmunt),
        address: theAddress,
        paymentMethods:paymentMethods);

    // Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressTxt.dispose();
    hometxt.dispose();
    areatxt.dispose();
    specialtxt.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final address = context.watch<UserProvider>().user.address;
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
            Center(
              child: Text(
                'add your Address',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Or tou have address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _AddressFormScreen,
                child: Column(
                  children: [
                    CustemText(
                      controller: hometxt,
                      lable: 'Home,Number',
                      icon: Icons.home,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustemText(
                      controller: addressTxt,
                      lable: 'address',
                      icon: Icons.streetview_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustemText(
                      controller: areatxt,
                      lable: 'Area Street',
                      icon: Icons.add_business_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustemText(
                      controller: specialtxt,
                      lable: 'Special Mark',
                      icon: Icons.mark_as_unread_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GooglePayButton(
                      width: double.infinity,
                      paymentConfiguration:
                          PaymentConfiguration.fromJsonString(defaultGooglePay),
                      paymentItems: _paymentItems,
                      type: GooglePayButtonType.pay,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: (paymentResult) {
                        payPressed(address, "GPAY");
                      },
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Custembutten(
                      onTap: () {
                        payPressed(address,"CASH");
                      },
                      text: 'cash on delivery',
                      icon: Icons.money,
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
