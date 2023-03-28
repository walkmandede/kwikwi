import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void showAlertDialog({required String content,bool xDismissible = true}){

  Get.dialog(
    CupertinoAlertDialog(
      title: Text(content),
    ),
    barrierDismissible: xDismissible
  );

}