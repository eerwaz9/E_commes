import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/app/providers/user_provider.dart';
import 'package:shoping/app/screens/Auth_screen.dart';
import 'package:shoping/app/screens/admin_screen.dart';
import 'package:shoping/app/services/Auth_servics.dart';
import 'package:shoping/app/widgets/acount_button.dart';
import 'package:shoping/components/utils.dart';

class TopButton extends StatefulWidget {
  const TopButton({Key? key}) : super(key: key);

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  final Authservics authservics=Authservics();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Column(
      children: [
        Row(
          children: [
            AcontButton(
              txt: "Wish List",
              onClick: () {},
            ),
            AcontButton(
              txt: "log out",
              onClick: () {
                showAlertDialog(context, () {authservics.LougUot(context); }, 'Stop', 'Do you want loug out');
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AcontButton(
              txt: "Admin Tool",
              onClick: () {
                if (user.type == "admin") {
                  Navigator.pushNamed(context, AdminScreen.routeName);
                } else {
                  showAlertDialog2(
                      context, 'stop', 'you don\'have an access permeation ');
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
