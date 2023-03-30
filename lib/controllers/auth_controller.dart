import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kwikwi/globals/global_functions.dart';

class AuthController extends GetxController{

  TextEditingController txtLoginEmail = TextEditingController(text: '');
  TextEditingController txtLoginPassword = TextEditingController(text: '');

  TextEditingController txtRegisterEmail = TextEditingController(text: '');
  TextEditingController txtRegisterPassword = TextEditingController(text: '');
  TextEditingController txtRegisterConfirmPassword = TextEditingController(text: '');




  Future<void> onClickRegister() async{
    showAlertDialog(content: 'Please wait',xDismissible: false);

    try{
      print('first print');
      await Future.delayed(const Duration(seconds: 2));
      print('second print');
    }
    catch(e){
      null;
    }

    Get.back();
  }

}