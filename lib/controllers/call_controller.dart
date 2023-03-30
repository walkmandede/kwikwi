import 'package:flutter/cupertino.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/models/kwikwi_request.dart';
import 'package:kwikwi/services/mongo_services.dart';
import 'package:kwikwi/services/network_call_services.dart';
import 'package:kwikwi/views/home_main_page.dart';

import '../globals/global_functions.dart';

enum PageTab {
  body,
  header,
}

class CallController extends GetxController{

  PageTab pageTab = PageTab.body;
  TextEditingController txtUrl = TextEditingController(text: '');
  Response? response;
  ProjectController projectController = Get.find();
  bool xCalling = false;
  bool xLoading = true;

  bool xHideRequestPanel = false;
  bool xHideResponsePanel = false;

  KwiKwiRequest kwiKwiRequest = KwiKwiRequest(
      requestId: '',
      name: '',
      collectionId: '',
      projectId: '',
      requestMethod: RequestMethod.get,
      requestUrl: '',
      requestHeaders: {
        "content-type": "application/json; charset=utf-8"
      },
      requestBody: {}
  );

  @override
  void onInit() {
    super.onInit();
    null;
  }

  @override
  void dispose() {
    super.dispose();
    null;
  }

  Future<void> initLoad({required KwiKwiRequest request}) async{

    try{
      kwiKwiRequest = request;
      txtUrl.text = request.requestUrl;
      response = null;
      xLoading = false;
    }
    catch(e){
      superPrint(e);
    }

    update();
  }

  void onChangeMethod(RequestMethod requestMethod){
    kwiKwiRequest.requestMethod = requestMethod;
    switch(kwiKwiRequest.requestMethod){
      case RequestMethod.get:
        break;
      case RequestMethod.post:
        break;
      case RequestMethod.put:
        break;
      case RequestMethod.delete:
        break;
    }
    update();
  }



  Future<void> onClickSubmit() async{

    xCalling = true;
    update();
    try{
      switch(kwiKwiRequest.requestMethod){
        case RequestMethod.get:
          response = await NetworkCallServices().getCall(request: kwiKwiRequest);
          break;
        case RequestMethod.post:
          response = await NetworkCallServices().postCall(request: kwiKwiRequest);
          break;
        case RequestMethod.put:
          response = await NetworkCallServices().putCall(request: kwiKwiRequest);
          break;
        case RequestMethod.delete:
          response = await NetworkCallServices().deleteCall(request: kwiKwiRequest);
          break;
      }
    }
    catch(e){
      superPrint(e);
    }

    xCalling = false;

    update();

  }

  Future<void> onClickSave() async{
    showAlertDialog(content: 'Please wait!',xDismissible: false);
    try{
      await MongoDatabase().updateDocument(
        objectId: kwiKwiRequest.requestId,
        colName: MongoDatabase.colRequests,
        json: kwiKwiRequest.convertToMap()
      );
      Get.back();
    }
    catch(e){
      Get.back();
      showAlertDialog(content: 'Something went wrong!',xDismissible: true);
    }
  }

  Future<void> onClickDelete() async{
    showAlertDialog(content: 'Please wait!',xDismissible: false);
    try{
      var response = await MongoDatabase().deleteDocument(colName: MongoDatabase.colRequests, objectId: kwiKwiRequest.requestId);
      await projectController.initLoad();
      Get.back();
      superPrint(response);
      Get.offAll(()=> const HomeMainPage());
    }
    catch(e){
      Get.back();
      showAlertDialog(content: 'Something went wrong!',xDismissible: true);
    }
  }

}