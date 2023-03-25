import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: Colors.grey.withOpacity(0.2)
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
        GestureDetector(
          onTap: () {
            toggleSideBarWidth();
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: Get.height * 0.05,
            child: Text('Kwi')
          ),
        ),
        const Divider(),
        Expanded(
            child: minSideBarTabsWidget()
        ),
        const Divider(),
        IconButton(onPressed: () async{
          await onClickLogOut();
        }, icon: const Icon(Icons.logout_outlined))
      ],
    );
  }

  Widget maxBar(){
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            toggleSideBarWidth();
          },
          child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: Get.height * 0.05,
              child: Text('Kwi Kwi')
          ),
        ),
        Container(
          color: Colors.grey.withOpacity(0.2),
          width: double.infinity,
          height: 1.2,
        ),
        Expanded(
            child: maxSideBarTabsWidget()
        ),
        Container(
          color: Colors.grey.withOpacity(0.2),
          width: double.infinity,
          height: 1.2,
        ),
        GestureDetector(
          onTap: () async{
            await onClickLogOut();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            child: const Text('Log Out',style: TextStyle(color: Colors.white),),
          ),
        )
      ],
    );
  }

  Widget minSideBarTabsWidget(){
    return GetBuilder<HomeMainController>(
      builder: (homeMainController) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [],
            )
          ),
        );
      },
    );
  }

  Widget maxSideBarTabsWidget(){
    return GetBuilder<HomeMainController>(
      builder: (homeMainController) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              children: []
            ),
          ),
        );
      },
    );
  }
}
