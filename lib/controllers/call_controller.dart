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

  Map<String,dynamic> requestBody = {};
  Map<String,dynamic> requestHeaders = {};

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
    requestBody.clear();
    requestHeaders.clear();
    try{
      kwiKwiRequest = request;
      txtUrl.text = request.requestUrl;
      response = null;
      kwiKwiRequest.requestBody.forEach((key, value) {
        requestBody[key] = value;
      });
      kwiKwiRequest.requestHeaders.forEach((key, value) {
        requestHeaders[key] = value;
      });
      xLoading = false;
    }
    catch(e){
      superPrint(e);
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
        // TODO: Handle this case.
          break;
        case RequestMethod.delete:
        // TODO: Handle this case.
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
    superPrint(kwiKwiRequest.convertToMap());
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