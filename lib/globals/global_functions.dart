import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAlertDialog({required String content,bool xDismissible = true}){

  Get.dialog(
    Theme(
      data: ThemeData.dark(),
      child: CupertinoAlertDialog(
        title: Text(content),
      ),
    ),
    barrierDismissible: xDismissible
  );

}

String getPrettyJson({required String rawString}){
  return const JsonEncoder.withIndent('  ').convert(json.decode(rawString));
}