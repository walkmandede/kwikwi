import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kwikwi/controllers/auth_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/views/auth/register_page.dart';

import '../../models/kwikwi_request.dart';
import '../call_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Size screenSize = MediaQuery.of(context).size;
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
                width: screenSize.width * 0.35,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Welcome to Kwi Kwi',style: TextStyle(color: Colors.white,fontSize: 20),),
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
                        controller: controller.txtLoginEmail,
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
                        controller: controller.txtLoginPassword,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white,fontSize: 12),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.width * 0.35,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.onClickEnter();
                        },
                        child: const Text('Enter',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: () {
                          Get.to((){
                            return const RegisterPage();
                          });
                        }, child: const Text('Create An Account',style: TextStyle(color: Colors.pinkAccent,fontSize: 12),)),
                        TextButton(onPressed: () {
                          Get.to((){
                            return CallPage(
                                kwiKwiRequest: KwiKwiRequest(
                                    collectionId: '',
                                    requestId: '',
                                    projectId: '',
                                    requestUrl: '',
                                    requestBody: {},
                                    requestHeaders: {},
                                    requestMethod: RequestMethod.get,
                                    name: ''
                                )
                            );
                          });
                        }, child: const Text('Enter Guest Mode',style: TextStyle(color: Colors.grey,fontSize: 12),)),
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
