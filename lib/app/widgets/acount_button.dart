import 'package:flutter/material.dart';

class AcontButton extends StatelessWidget {
  const AcontButton({Key? key,required this.txt,required this.onClick}) : super(key: key);
final String txt;
final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white,width: 0.0),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: OutlinedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
            primary: Colors.black12.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(txt,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),),

        ),
      ),
    );
  }
}
