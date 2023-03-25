import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikwi/globals/global_constants.dart';

import '../../controllers/home_main_controller.dart';

class HomeSideBarTab{
  String name;
  String short;

  HomeSideBarTab({required this.name,required this.short});

}

class HomeSideBar extends StatefulWidget {
  const HomeSideBar({Key? key}) : super(key: key);

  @override
  State<HomeSideBar> createState() => _HomeSideBarState();
}

class _HomeSideBarState extends State<HomeSideBar> with SingleTickerProviderStateMixin{

  late AnimationController sideBarAnimation;


  @override
  void initState() {
    super.initState();
    sideBarAnimation = AnimationController(vsync: this,duration: const Duration(milliseconds: 300),value: 1);
  }

  @override
  void dispose() {
    super.dispose();
    null;
  }

  Future<void> onClickLogOut() async{
    // Get.offAll(()=> const LoginPage());
  }

  void toggleSideBarWidth(){
    sideBarAnimation.isCompleted?sideBarAnimation.reverse():sideBarAnimation.forward();
  }

  Future<void> onClickAddNewCollection() async{

  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sideBarAnimation,
      builder: (context, child) {
        double value = sideBarAnimation.value;
        return GestureDetector(
          onHorizontalDragEnd: (details) {
            if(!sideBarAnimation.isAnimating){
              if(details.primaryVelocity! < 0 ){
                sideBarAnimation.reverse();
              }
              else{
                sideBarAnimation.forward();
              }
            }
          },
          child: Container(
            width: Get.width * 0.05 + (Get.width * 0.15* value),
            padding: const EdgeInsets.symmetric(vertical: 20),
            height: double.infinity,
            decoration:const BoxDecoration(
              color: GlobalConstants.mainColor,
              border: Border(
                right: BorderSide(
                  color: GlobalConstants.borderColor,
                  width: GlobalConstants.borderWidth
                )
              )
            ),
            child: value<0.8?minBar():maxBar(),
          ),
        );
      },
    );
  }

  Widget minBar(){
    return Column(
      children: [
      ],
    );
  }

  Widget maxBar(){
    return Column(
      children: [

      ],
    );
  }

}
