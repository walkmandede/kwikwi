
import 'package:get/get.dart';

class HomeMainController extends GetxController{

  bool xDrawerOpened = false;
  String currentTab = '';

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }
  
  @override
  void onClose() {
    null;
    super.onClose();
  }
  
  Future<void> initLoad() async{

    update();
  }


}