import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kwikwi/controllers/home_main_controller.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/views/auth/login_page.dart';
import 'package:kwikwi/views/call_page.dart';
import 'package:kwikwi/views/project_page.dart';
import 'package:kwikwi/views/widgets/loading_screen.dart';
import 'package:kwikwi/views/widgets/side_bar.dart';
import 'package:get/get.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeMainController());
    HomeMainController homeMainController = Get.find();
    homeMainController.updateScreenSize(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: GlobalConstants.bgColor,
      body: GetBuilder<HomeMainController>(
        builder: (controller) {
          if(controller.xLoading){
            return const LoadingScreen();
          }
          else{
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child:  Row(
                children: [
                  // const HomeSideBar(),
                  Expanded(
                    child: bodyWidget(),
                  ),
                ],
              ),
            );
          }
        }
      ),
    );
  }

  Widget bodyWidget(){
    HomeMainController homeMainController = Get.find();
    Widget shownWidget = Container();
    switch(homeMainController.currentTab){
      case HomePageTab.project:
        shownWidget = const ProjectPage();
    }

    return Row(
      children: [
        menuBar(),
        Expanded(
          child: shownWidget,
        )
      ],
    );
  }

  Widget menuBar(){
    return Container(
      height: double.infinity,
      // width: Get.width * 0.05,
      padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 20),
      decoration: const BoxDecoration(
        color: GlobalConstants.secondaryColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('KK',style: TextStyle(color: Colors.white,fontSize: 12,),),
          Container(
            width: 20,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Divider(
              color: Colors.white,
            ),
          ),
          IconButton(onPressed: () {
          }, icon: const Icon(Iconsax.folder,color: Colors.white,)),
          IconButton(onPressed: () {
          }, icon: const Icon(Iconsax.data,color: Colors.white,)),
          const Spacer(),
          IconButton(onPressed: () {
          }, icon: const Icon(Iconsax.setting,color: Colors.white,)),
          IconButton(onPressed: () {
            Get.offAll(()=> const LoginPage());
          }, icon: const Icon(Iconsax.logout,color: Colors.white,)),
        ],
      ),
    );
  }

}



