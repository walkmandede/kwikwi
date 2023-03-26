import 'package:flutter/cupertino.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:kwikwi/models/kwikwi_request.dart';
import 'package:kwikwi/services/network_call_services.dart';

enum PageTab {
  body,
  header,
}

class FreeCallController extends GetxController{

  PageTab pageTab = PageTab.body;
  TextEditingController txtUrl = TextEditingController(text: '');
  Response? response;
  bool isRequesting = false;

  KwiKwiRequest kwiKwiRequest = KwiKwiRequest(
      id: '',
      requestMethod: RequestMethod.get,
      url: '',
      headers: {
        "content-type": "application/json; charset=utf-8"
      },
      body: {}
  );

  Future<void> onClickSubmit() async{
    isRequesting = true;
    update();

    switch(kwiKwiRequest.requestMethod){
      case RequestMethod.get:
        response = await NetworkCallServices().getCall(request: kwiKwiRequest);
        break;
      case RequestMethod.post:
        // TODO: Handle this case.
        break;
      case RequestMethod.put:
        // TODO: Handle this case.
        break;
      case RequestMethod.delete:
        // TODO: Handle this case.
        break;
    }


    isRequesting = false;
    update();

  }

}