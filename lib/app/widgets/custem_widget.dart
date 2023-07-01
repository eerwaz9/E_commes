import 'package:flutter/material.dart';

class CustemText extends StatefulWidget {
  final TextEditingController controller;
  final String lable;
  final int maxLains;
  final IconData? icon;
  // ignore: prefer_typing_uninitialized_variables
  final isPassword;
  const CustemText(
      {Key? key,
      required this.controller,
      required this.lable,
      this.maxLains = 1,
      this.icon,
      this.isPassword = false})
      : super(key: key);

  @override
  State<CustemText> createState() => _CustemTextState();
}

class _CustemTextState extends State<CustemText> {
  bool inVisibe = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inVisibe == widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: inVisibe,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      inVisibe =! inVisibe;
                    });

                  },
                  icon: Icon(inVisibe
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                ) : null,
          hintText: widget.lable,
          hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38))
      ),
      validator: (val) {

        if (val == null || val.isEmpty) {
          return "Enter your ${widget.lable}";
        }
        return null;
      },
      maxLines: widget.maxLains,
    );
  }
}
