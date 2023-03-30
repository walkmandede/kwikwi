import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:json_editor/json_editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikwi/controllers/call_controller.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/globals/global_functions.dart';
import 'package:kwikwi/models/kwikwi_project.dart';
import 'package:kwikwi/views/home_main_page.dart';
import '../models/kwikwi_request.dart';

class CallPage extends StatelessWidget {
  final KwiKwiRequest kwiKwiRequest;
  const CallPage({Key? key,required this.kwiKwiRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CallController());
    CallController callController = Get.find();
    callController.initLoad(request: kwiKwiRequest);
    return Scaffold(
      body: RawKeyboardListener(
        onKey: (value) async{
          try{
            if(value.isKeyPressed(LogicalKeyboardKey.metaLeft) && value.character!.toUpperCase() == "S"){
              await callController.onClickSave();
            }
            else if(value.isKeyPressed(LogicalKeyboardKey.metaLeft) && value.isKeyPressed(LogicalKeyboardKey.enter)){
              await callController.onClickSubmit();
            }
          }
          catch(e){
            null;
          }

        },
        focusNode: FocusNode(),
        child: Container(
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
                    Expanded(child: midPanel()),
                    // bottomPanel(),
                  ],
                );
              },
            )
        ),
      ),
    );
  }

  Widget topPanel(KwiKwiRequest kwiKwiRequest) {
    CallController freeCallController = Get.find();
    return Container(
      padding:const EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 14),
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
              IconButton(onPressed: () {
                Get.offAll(()=> const HomeMainPage());
              }, icon: const Icon(Icons.arrow_back_ios_new_rounded,color: GlobalConstants.iconColor,)),
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
                            freeCallController.onChangeMethod(value);
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
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
      ),
    );
  }

  Widget midPanel() {
    CallController callController = Get.find();
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
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Row(
                      children: [
                        const Text('Request',style: TextStyle(color: GlobalConstants.textColor),),
                        IconButton(onPressed: () {
                          callController.xHideRequestPanel = !callController.xHideRequestPanel;
                          callController.update();
                        }, icon: Icon(callController.xHideRequestPanel?Icons.expand_more_rounded:Icons.expand_less_rounded,color: Colors.grey,))
                      ],
                    ),
                    const Spacer(),
                  ],
                )
            ),
            callController.xHideRequestPanel?Container(): Expanded(
              child: requestPanel(),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Row(
                      children: [
                        const Text('Response',style: TextStyle(color: GlobalConstants.textColor),),
                        IconButton(onPressed: () {
                          callController.xHideResponsePanel = !callController.xHideResponsePanel;
                          callController.update();
                        }, icon: Icon(callController.xHideRequestPanel?Icons.expand_more_rounded:Icons.expand_less_rounded,color: Colors.grey,))
                      ],
                    ),
                    const Spacer(),
                    const Text('Status Code : ',style: TextStyle(color: GlobalConstants.textColor),),
                    if(callController.response!=null)Text(callController.response!.statusCode.toString(),style: const TextStyle(color: GlobalConstants.textColor),)
                  ],
                )
            ),
            callController.xHideResponsePanel?Container():Expanded(
              child: responsePanel(),
            ),
          ],
        ),
        // child: ResizableWidget(
        //   isHorizontalSeparator: true,
        //   separatorColor: Colors.black,
        //   separatorSize: 1.2,
        //   children: [
        //     requestPanel(),
        //     responsePanel(),
        //   ],
        // ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Expanded(child: responsePanel())
        //     // widget,
        //   ],
        // )
    );
  }

  Widget requestPanel(){
    CallController freeCallController = Get.find();
    Widget widget = Container();
    switch (freeCallController.pageTab) {
      case PageTab.body:
        widget = bodyPanel();
        break;
      case PageTab.header:
        widget = headerPanel();
        break;
    }
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pageTabPanel(),
          Expanded(child: freeCallController.xHideRequestPanel?Container():widget),
        ],
      ),
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

  Widget bodyPanel() {
    CallController freeCallController = Get.find();
    Widget widget = Container();

    Map<String,dynamic> requestBody = {};

    freeCallController.kwiKwiRequest.requestBody.forEach((key, value) {
      requestBody[key] = value;
    });

    widget = JsonEditor.object(
      object: requestBody,
      enabled: true,
      onValueChanged: (value) async{
        freeCallController.kwiKwiRequest.requestBody = jsonDecode(jsonEncode( value.toObject()));
      },
    );

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
        child: freeCallController.xCalling?const CupertinoActivityIndicator(color: Colors.white,)
            :
        JsonEditorTheme(
            themeData: GlobalConstants().jsonTheme1,
            child: JsonPanel(widget: widget)
        )
    );
  }

  Widget headerPanel() {
    CallController freeCallController = Get.find();
    Map<String,dynamic> requestHeaders = {};

    freeCallController.kwiKwiRequest.requestHeaders.forEach((key, value) {
      requestHeaders[key] = value;
    });
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
            object: requestHeaders,
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
    String responseString = '';


    if(freeCallController.response!=null){
      responseString = freeCallController.response!.bodyString??'';
      try{
        responseString = getPrettyJson(rawString: responseString);
      }
      catch(e){
        null;
      }
    }


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: freeCallController.xHideResponsePanel?Container():Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: GlobalConstants.secondaryColor,
                    border: Border.all(color: GlobalConstants.iconColor),
                    borderRadius: BorderRadius.circular(10)
                ),
                alignment: Alignment.center,
                child: xCalling ?
                const CupertinoActivityIndicator(color: Colors.white,) :
                Align(
                  alignment: Alignment.topLeft,
                  child: TextField(
                    controller: TextEditingController(text: responseString),
                    maxLines: null,
                    readOnly: true,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      height: 1.5
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
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

class JsonPanel extends StatelessWidget {
  final Widget widget;
  const JsonPanel({Key? key,required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JsonEditorTheme(
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
      child: widget
    );
  }
}








