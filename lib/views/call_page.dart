import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:json_editor/json_editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikwi/controllers/call_controller.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/models/kwikwi_project.dart';

import '../models/kwikwi_request.dart';

class CallPage extends StatelessWidget {
  final KwiKwiRequest kwiKwiRequest;
  const CallPage({Key? key,required this.kwiKwiRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CallController());
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: GlobalConstants.bgColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GetBuilder<CallController>(
            builder: (controller) {
              return controller.xLoading?const Center(
              ):Column(
                children: [
                  topPanel(kwiKwiRequest),
                  Expanded(child: midPanel(requestHeaders: controller.requestHeaders,requestBody: controller.requestBody)),
                  // bottomPanel(),
                ],
              );
            },
          )
      ),
    );
  }

  Widget topPanel(KwiKwiRequest kwiKwiRequest) {
    CallController freeCallController = Get.find();
    return Container(
      padding:const EdgeInsets.symmetric(horizontal:15,vertical: 15),
      decoration: BoxDecoration(
        color: GlobalConstants.mainColor,
        borderRadius: BorderRadius.circular(GlobalConstants.borderRadius),
        border: Border.all(color: GlobalConstants.borderColor,width: 2)
      ),
      child: Column(
        children: [
          if(kwiKwiRequest.requestId.isNotEmpty)labelPanel(kwiKwiRequest),
          if(kwiKwiRequest.requestId.isNotEmpty)const SizedBox(height: 10,),
          Row(
            children: [
              //Request Method
              Container(
                height: 40,
                padding:const EdgeInsets.symmetric(horizontal: 15,),
                decoration: BoxDecoration(
                  border: Border.all(color:GlobalConstants.secondaryBorderColor),
                  borderRadius: BorderRadius.circular(4)
                ),
                      child: DropdownButton<RequestMethod>(
                        underline: Container(),
                        dropdownColor: GlobalConstants.secondaryColor,
                        icon: const  RotatedBox(
                            quarterTurns: 3,
                            child: Icon(Icons.arrow_back_ios_rounded,color: GlobalConstants.textColor,size: 10,)),
                        items: RequestMethod.values.map((e) {
                          return DropdownMenuItem<RequestMethod>(
                            value: e,
                            child: Text(e.name.toUpperCase(),style:const TextStyle(color: GlobalConstants.textColor),),
                          );
                        }).toList(),
                        value: freeCallController.kwiKwiRequest.requestMethod,
                        onChanged: (value) {
                          if(value!=null){
                            freeCallController.kwiKwiRequest.requestMethod = value;
                            freeCallController.update();
                          }
                        },
                      )
                    ),
              const SizedBox(width: 25,),
              Expanded(
                child: Container(
                  height: 40,
                  padding:const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: GlobalConstants.secondaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: TextField(
                      controller: freeCallController.txtUrl,
                      onChanged: (value) {
                        freeCallController.kwiKwiRequest.requestUrl = value;
                        },
                      cursorColor: GlobalConstants.secondaryBorderColor,
                      style:const TextStyle(color: Colors.white),
                      decoration:const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15,),
              IconButton(
                padding: EdgeInsets.zero,
                  onPressed: ()async{
                    await freeCallController.onClickSubmit();
                  },
                  icon:const Icon(Icons.send_rounded,color: GlobalConstants.iconColor,))
            ],
          ),
        ],
      ),
    );
  }

  Widget labelPanel(KwiKwiRequest kwiKwiRequest){
    CallController freeCallController = Get.find();
    ProjectController projectController = Get.find();
    KwiKwiProject kwiKwiProject = projectController.allProjects[kwiKwiRequest.projectId]!;
    KwiKwiCollection kwikwiCollection = projectController.allCollections[kwiKwiRequest.collectionId]!;
    return Row(
      children: [
        Text(kwiKwiProject.name,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: GlobalConstants.projectColor),),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.arrow_forward_ios_rounded,color: GlobalConstants.iconColor,size: 12,),
        ),
        Text(kwikwiCollection.name,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: GlobalConstants.collectionColor),),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.arrow_forward_ios_rounded,color: GlobalConstants.iconColor,size: 12,),
        ),
        Text(kwiKwiRequest.name,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: GlobalConstants.requestColor),),
        const Spacer(),
        IconButton(onPressed: () async{
          await freeCallController.onClickDelete();
        }, icon: const Icon(Icons.delete,color: Colors.redAccent,)),
        IconButton(onPressed: () async{
          await freeCallController.onClickSave();
        }, icon: const Icon(Icons.save_rounded,color: Colors.lightBlueAccent,)),
      ],
    );
  }

  Widget midPanel({required Map<String,dynamic> requestBody,required Map<String,dynamic> requestHeaders}) {
    CallController freeCallController = Get.find();
    Widget widget = Container();
    switch (freeCallController.pageTab) {
      case PageTab.body:
        if(freeCallController.kwiKwiRequest.requestId.isNotEmpty){
          widget = bodyPanel(requestBody);
        }
        break;
      case PageTab.header:
        if(freeCallController.kwiKwiRequest.requestId.isNotEmpty){
          widget = headerPanel(requestHeaders);
        }
        break;
    }

    return Container(
      width: double.maxFinite,
        height: double.maxFinite,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: GlobalConstants.mainColor,
            border: Border.all(color: GlobalConstants.borderColor,width: 2),
            borderRadius: BorderRadius.circular(GlobalConstants.borderRadius)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                child: Row(
                  children: const [
                    Text('Request',style: TextStyle(color: GlobalConstants.textColor),),
                  ],
                )
            ),
            pageTabPanel(),
            Expanded(child: widget),
            Expanded(child: responsePanel())
            // widget,
          ],
        )
    );
  }

  Widget pageTabPanel(){
    return GetBuilder<CallController>(
      builder:(controller)=> Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:PageTab.values.map((e) =>
              GestureDetector(
                onTap: (){
                  controller.pageTab = e;
                  controller.update();
                },
                child: Container(
            padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color:controller.pageTab==e?GlobalConstants.hightLightColor:Colors.transparent,width: 2.5))
            ),
            child: Text(e.name.toUpperCase(),style:const TextStyle(color: GlobalConstants.textColor),),
          ),
              )).toList()
        ),
      ),
    );
  }

  Widget bottomPanel() {
    CallController freeCallController = Get.find();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Row(
        children: PageTab.values.map((e) {
          return Expanded(
              child: Container(
                height: Get.height * 0.05,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    freeCallController.pageTab = e;
                    freeCallController.update();
                  },
                  child: Text(e.name.toUpperCase()),
                ),
              )
          );
        }).toList(),
      ),
    );
  }

  Widget bodyPanel(Map<String,dynamic> requestBody) {
    CallController freeCallController = Get.find();
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: GlobalConstants.secondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white30)
        ),
        child: freeCallController.xCalling?const CupertinoActivityIndicator(color: Colors.white,):JsonEditorTheme(
          themeData: JsonEditorThemeData(
            darkTheme: JsonTheme(
                stringStyle:const TextStyle(color: Colors.redAccent, fontSize: 10)
            ),
            lightTheme: JsonTheme(
              stringStyle:const TextStyle(color: Colors.lightGreenAccent, fontSize: 10,),
              boolStyle:const TextStyle(color: Colors.purpleAccent, fontSize: 10,),
              keyStyle:const TextStyle(color: Colors.white,fontSize: 10),
              bracketStyle: const TextStyle(color: Colors.orangeAccent,fontSize: 10),
              defaultStyle: const TextStyle(color: Colors.grey,fontSize: 10)
            ),
          ),
          child: JsonEditor.object(
            object: requestBody,
            enabled: true,
            onValueChanged: (value) async{
              freeCallController.kwiKwiRequest.requestBody = jsonDecode(jsonEncode( value.toObject()));
            },
          ),
        )
    );
  }

  Widget headerPanel(Map<String,dynamic> requestHeader) {
    CallController freeCallController = Get.find();
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: GlobalConstants.secondaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white30)
        ),
        child: freeCallController.xCalling?const CupertinoActivityIndicator(color: Colors.white,):JsonEditorTheme(
          themeData: GlobalConstants().jsonTheme1,
          child: JsonEditor.object(
            object: requestHeader,
            // object: freeCallController.kwiKwiRequest.headers,
            enabled: true,
            onValueChanged: (value) {
              freeCallController.kwiKwiRequest.requestHeaders = value.toJson();
            },
          ),
        )
    );
  }

  Widget responsePanel() {
    CallController freeCallController = Get.find();
    bool xCalling = freeCallController.xCalling;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const Text('Response',style: TextStyle(color: GlobalConstants.textColor),),
                const Spacer(),
                const Text('Status Code : ',style: TextStyle(color: GlobalConstants.textColor),),
                if(freeCallController.response!=null)Text(freeCallController.response!.statusCode.toString(),style: const TextStyle(color: GlobalConstants.textColor),)
              ],
            )
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: GlobalConstants.secondaryColor,
                    border: Border.all(color: GlobalConstants.iconColor),
                    borderRadius: BorderRadius.circular(10)
                ),
                alignment: Alignment.center,
                child: xCalling?const CupertinoActivityIndicator(color: Colors.white,):JsonEditorTheme(
                  themeData: JsonEditorThemeData(
                    darkTheme: JsonTheme(
                        stringStyle:const TextStyle(color: Colors.redAccent, fontSize: 10)
                    ),
                    lightTheme: JsonTheme(
                      stringStyle:const TextStyle(color: Colors.lightGreenAccent, fontSize: 10,),
                      boolStyle:const TextStyle(color: Colors.purpleAccent, fontSize: 10,),
                      keyStyle:const TextStyle(color: Colors.grey,fontSize: 10),
                      bracketStyle: const TextStyle(color: Colors.orangeAccent,fontSize: 10),
                    ),
                  ),
                  child: JsonEditor.string(
                    jsonString: freeCallController.response == null
                        ? ""
                        : freeCallController.response!.bodyString,
                    enabled: false,
                    onValueChanged: (value) {},
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }


  Widget allPanel() {
    return Container();
  }


}
