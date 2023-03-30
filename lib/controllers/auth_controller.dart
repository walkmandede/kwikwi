import 'package:flutter/cupertino.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/globals/global_functions.dart';
import 'package:kwikwi/models/kwikwi_user.dart';
import 'package:kwikwi/services/mongo_services.dart';
import 'package:kwikwi/views/auth/login_page.dart';
import 'package:kwikwi/views/home_main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{

  TextEditingController txtLoginEmail = TextEditingController(text: '');
  TextEditingController txtLoginPassword = TextEditingController(text: '');

  TextEditingController txtRegisterEmail = TextEditingController(text: '');
  TextEditingController txtRegisterPassword = TextEditingController(text: '');
  TextEditingController txtRegisterConfirmPassword = TextEditingController(text: '');


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  Future<void> initLoad() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences.containsKey(GlobalConstants.spEmail)){
      txtLoginEmail.text = sharedPreferences.getString(GlobalConstants.spEmail)??'';
    }
    if(sharedPreferences.containsKey(GlobalConstants.spPassword)){
      txtLoginPassword.text = sharedPreferences.getString(GlobalConstants.spPassword)??'';
    }

  }

  bool isEmailValid(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  Future<void> onClickRegister() async{
    showAlertDialog(content: 'Please wait',xDismissible: false);

    if(txtRegisterEmail.text.isEmpty || txtRegisterPassword.text.isEmpty || txtRegisterConfirmPassword.text.isEmpty){
      Get.back();
      showAlertDialog(content: 'Please fill all data');
    }
    else if(!isEmailValid(txtRegisterEmail.text)){
      Get.back();
      showAlertDialog(content: 'Invalid email format');
    }
    else if(txtRegisterPassword.text.isEmpty != txtRegisterConfirmPassword.text.isEmpty){
      Get.back();
      showAlertDialog(content: 'Passwords do no match!');
    }
    else{
      try{
        KwiKwiUser kwiKwiUser = KwiKwiUser(
            id: '',
            email: txtRegisterEmail.text,
            password: txtRegisterPassword.text
        );
        await MongoDatabase().insertDataIntoCollection(colName: MongoDatabase.colUsers, data: kwiKwiUser.convertToMap());
        Get.back();
        Get.offAll(()=> const LoginPage());
        showAlertDialog(content: 'Account Created Successfully!');
      }
      catch(e){
        Get.back();
        showAlertDialog(content: 'Something went wrong');
        null;
      }
    }
  }

  Future<void> onClickEnter() async{
    showAlertDialog(content: 'Please wait',xDismissible: false);

    if(txtLoginEmail.text.isEmpty || txtLoginPassword.text.isEmpty){
      Get.back();
      showAlertDialog(content: 'Please fill all data');
    }
    else if(!isEmailValid(txtLoginEmail.text)){
      Get.back();
      showAlertDialog(content: 'Invalid email format');
    }
    else{
      try{
        List<Map> data = await MongoDatabase().getCollectionAllData(colName: MongoDatabase.colUsers);
        Get.back();
        bool xValid = false;
        for (var element in data) {
          String email = element['email'].toString();
          String password = element['password'].toString();
          if(email == txtLoginEmail.text && password == txtLoginPassword.text){
            xValid = true;
            break;
          }
          else{
            xValid = false;
          }
        }


        if(xValid){
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString(GlobalConstants.spEmail, txtLoginEmail.text);
          await sharedPreferences.setString(GlobalConstants.spPassword, txtLoginPassword.text);
          Get.offAll(()=> const HomeMainPage());
        }
        else{
          showAlertDialog(content: 'Invalid Login');
        }

      }
      catch(e){

        null;
      }
    }
  }

}