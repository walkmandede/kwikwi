import 'package:flutter/services.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:kwikwi/controllers/project_controller.dart';

enum HomePageTab{
  project,
}

class HomeMainController extends GetxController{

  bool xDrawerOpened = false;
  bool xLoading = true;
  HomePageTab currentTab = HomePageTab.project;

  Size screeenSize = const Size(100, 100);

  @override
  void onInit() {
    super.onInit();
    initLoad();
  }
  
  @override
  void onClose() {
    null;
    super.onClose();
  }

  void updateScreenSize(Size size){
    screeenSize = size;
    update();
  }
  
  Future<void> initLoad() async{
    ProjectController projectController = Get.find();
    try{
      await projectController.initLoad();
    }
    catch(e){
      superPrint(e);
    }
    xLoading = false;
    update();
  }


}