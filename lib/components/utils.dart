import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

//تقم بعمل رسالة لتتبع خطوات التفيذ
// void showSnakBar(BuildContext context, String Txt) async {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Txt)));
// }
void showSnakBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(text),
  ),   ); }
Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

showAlertDialog(
    BuildContext context, VoidCallback onOk, String txtHead, String txtmsg) {
  Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text("cancel"),
  );
  Widget okButton = TextButton(
    onPressed: onOk,
    child: Text("Ok"),
  );

  AlertDialog alertDialog = AlertDialog(
    title: Text(txtHead),
    content: Text(txtmsg),
    actions: [cancelButton, okButton],
  );
  showDialog(context: context, builder: (BuildContext context){
    return alertDialog;
  });
}
showAlertDialog2(
    BuildContext context,   String txtHead, String txtmsg) {
  Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: const Text("Ok"),
  );


  AlertDialog alertDialog = AlertDialog(
    title: Text(txtHead),
    content: Text(txtmsg),
    actions: [cancelButton],
  );
  showDialog(context: context, builder: (BuildContext context){
    return alertDialog;
  });


}
String getstatus(int vale){
  switch (vale){
    case 0:
      return "pending";
    case 1:
      return "preparing";
    case 2:
      return "Ready";
    case 3:
      return "On way";
    case 4:
      return "Completed";
    default:
      return "preparing";
  }
}
Color getStatusColor(int vale){
  switch (vale){
    case 0:
      return Colors.green;"perspire";
    case 1:
      return Colors.blue;
    case 2:
      return Colors.yellowAccent;
    case 3:
      return Colors.deepOrangeAccent;
    case 4:
      return Colors.red;
    default:
      return Colors.green;
  }


}


double getProportionateScreenHeight(double inputHeight,BuildContext context){
double ScreenHegth=MediaQuery.of(context).size.height;
return (inputHeight/812.0)*ScreenHegth;
}
double getProportionateScreenWidth(double inputWidth,BuildContext context){
  // ignore: non_constant_identifier_names
  double ScreenWidth=MediaQuery.of(context).size.width;
  return (inputWidth/375.0)*ScreenWidth;
}