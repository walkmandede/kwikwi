import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kwikwi/controllers/auth_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';

import '../../models/kwikwi_request.dart';
import '../call_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: GlobalConstants.bgColor
            ),
            alignment: Alignment.center,
            child: Card(
              elevation: 20,
              color: GlobalConstants.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                width: Get.width * 0.35,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Create An Account',style: TextStyle(color: Colors.white,fontSize: 20),),
                    const SizedBox(height: 20,),
                    const Text('Email',style: TextStyle(color: Colors.grey,fontSize: 15),),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: GlobalConstants.secondaryBorderColor
                          )
                      ),
                      child: TextField(
                        controller: controller.txtRegisterEmail,
                        style: const TextStyle(color: Colors.white,fontSize: 12),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text('Password',style: TextStyle(color: Colors.grey,fontSize: 15),),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: GlobalConstants.secondaryBorderColor
                          )
                      ),
                      child: TextField(
                        controller: controller.txtRegisterPassword,
                        style: const TextStyle(color: Colors.white,fontSize: 12),
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text('Confirm Password',style: TextStyle(color: Colors.grey,fontSize: 15),),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: GlobalConstants.secondaryBorderColor
                          )
                      ),
                      child: TextField(
                        controller: controller.txtRegisterConfirmPassword,
                        style: const TextStyle(color: Colors.white,fontSize: 12),
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width * 0.35,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.onClickRegister();
                        },
                        child: const Text('Register',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: () {
                          Get.back();
                        }, child: const Text('Back',style: TextStyle(color: Colors.grey),))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
