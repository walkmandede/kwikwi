import 'dart:convert';

import 'package:json_editor/json_editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikwi/controllers/free_call_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import '../models/kwikwi_request.dart';

class FreeCallPage extends StatelessWidget {
  const FreeCallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FreeCallController());
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: GlobalConstants.bgColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GetBuilder<FreeCallController>(
            builder: (controller) {
              return Column(
                children: [
                  topPanel(),
                  Expanded(child: midPanel()),
                  Expanded(child: responsePanel())
                  // bottomPanel(),
                ],
              );
            },
          )
      ),
    );
  }

  Widget topPanel() {
    FreeCallController freeCallController = Get.find();
    return Container(
      padding:const EdgeInsets.symmetric(horizontal:15,vertical: 15),
      decoration: BoxDecoration(
        color: GlobalConstants.mainColor,
        borderRadius: BorderRadius.circular(GlobalConstants.borderRadius),
        border: Border.all(color: GlobalConstants.borderColor,width: 2)
      ),
      child: Row(
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
                    freeCallController.kwiKwiRequest.url = value;
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
          GestureDetector(
            onTap: ()async{
                    await freeCallController.onClickSubmit();
            },
            child: Container(
                height: 40,
                padding:const EdgeInsets.symmetric(horizontal: 15,),
                decoration: BoxDecoration(
                    border: Border.all(color:GlobalConstants.secondaryBorderColor),
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:const [
                    Text('Send',style: TextStyle(color: GlobalConstants.textColor),),
                    SizedBox(width: 10,),
                     Icon(Icons.send_rounded,color: GlobalConstants.iconColor,size: 18,)
                  ],
                )
            ),
          ),
        ],
      ),
    );
    // return Row(
    //   children: [
    //     Container(
    //       padding: const EdgeInsets.symmetric(horizontal: 20),
    //       decoration: BoxDecoration(
    //           color: Colors.blueGrey,
    //           borderRadius: BorderRadius.circular(6)
    //       ),
    //       child: DropdownButton<RequestMethod>(
    //         underline: Container(),
    //         dropdownColor: Colors.blueGrey,
    //         icon: Container(),
    //         items: RequestMethod.values.map((e) {
    //           return DropdownMenuItem<RequestMethod>(
    //             value: e,
    //             child: Text(e.name.toUpperCase(),style: TextStyle(color: Colors.white),),
    //           );
    //         }).toList(),
    //         value: freeCallController.kwiKwiRequest.requestMethod,
    //         onChanged: (value) {
    //           if(value!=null){
    //             freeCallController.kwiKwiRequest.requestMethod = value;
    //             freeCallController.update();
    //           }
    //         },
    //       ),
    //     ),
    //     const SizedBox(width: 8,),
    //     Expanded(
    //       child: Container(
    //         width: double.infinity,
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         decoration: BoxDecoration(
    //           color: Colors.blueGrey,
    //           borderRadius: BorderRadius.circular(6),
    //         ),
    //         child: TextField(
    //           controller: freeCallController.txtUrl,
    //           cursorColor: Colors.white,
    //           style: const TextStyle(color: Colors.white,fontWeight: FontWeight.normal),
    //           decoration: const InputDecoration(
    //             border: InputBorder.none,
    //           ),
    //           onChanged: (value) {
    //             freeCallController.kwiKwiRequest.url = value;
    //           },
    //         ),
    //       ),
    //     ),
    //     const SizedBox(width: 8,),
    //     IconButton(
    //       onPressed: () async{
    //         await freeCallController.onClickSubmit();
    //       },
    //       icon: const Icon(Icons.send,color: Colors.blueGrey,),
    //     )
    //   ],
    // );
  }



  Widget midPanel() {
    FreeCallController freeCallController = Get.find();
    Widget shownWidget = Container();
    switch (freeCallController.pageTab) {
      case PageTab.body:
        shownWidget = bodyPanel();
        break;
      case PageTab.header:
        shownWidget = headerPanel();
        break;
    }

    return Container(
      width: double.maxFinite,
        height: double.maxFinite,
        margin: const EdgeInsets.only(top: 20),
        padding:const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: GlobalConstants.mainColor,
            border: Border.all(color: GlobalConstants.borderColor,width: 2),
            borderRadius: BorderRadius.circular(GlobalConstants.borderRadius)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pageTapPanel(),
            Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  margin:const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: GlobalConstants.bgColor,
                      borderRadius: BorderRadius.circular(GlobalConstants.borderRadius)
                  ),
                  child: shownWidget,
                )
            ),
          ],
        )
    );
  }

  Widget pageTapPanel(){
    return GetBuilder<FreeCallController>(
      builder:(controller)=> Row(
        mainAxisSize: MainAxisSize.min,
        children:PageTab.values.map((e) =>
            GestureDetector(
              onTap: (){
                controller.pageTab = e;
                controller.update();
              },
              child: Container(
          padding:const EdgeInsets.only(left: 20,right: 20, bottom: 10),
          decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color:controller.pageTab==e?GlobalConstants.hightLightColor:Colors.transparent,width: 2.5))
          ),
          child: Text(e.name.toUpperCase(),style:const TextStyle(color: GlobalConstants.textColor),),
        ),
            )).toList()
      ),
    );
  }

  Widget bottomPanel() {
    FreeCallController freeCallController = Get.find();
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
    return GetBuilder<FreeCallController>(
      builder:(freeCallController)=> Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: JsonEditorTheme(
            themeData: JsonEditorThemeData(
              darkTheme: JsonTheme(
                bracketStyle:const TextStyle(color: GlobalConstants.textColor),
              ),
              lightTheme: JsonTheme(
                  bracketStyle:const TextStyle(color: GlobalConstants.textColor),
              ),
            ),
            child: JsonEditor.string(
              jsonString: "",
              enabled: true,
              onValueChanged: (value) {
                freeCallController.kwiKwiRequest.body = value.toJson();
                freeCallController.update();
              },
            ),
          )
      ),
    );
  }

  Widget headerPanel() {
    return GetBuilder<FreeCallController>(
      builder:(freeCallController)=> Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: JsonEditorTheme(
            themeData: JsonEditorThemeData(
              darkTheme: JsonTheme(
                bracketStyle:const TextStyle(color: GlobalConstants.textColor),
              ),
              lightTheme: JsonTheme(
                bracketStyle:const TextStyle(color: GlobalConstants.textColor),
              ),
            ),
            child: JsonEditor.string(
              jsonString: "",
              enabled: true,
              onValueChanged: (value) {
                freeCallController.kwiKwiRequest.headers = value.toJson() as Map<String,String>;
                freeCallController.update();
              },
            ),
          )
      ),
    );
  }

  Widget responsePanel() {
    FreeCallController freeCallController = Get.find();
    return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        margin:const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: GlobalConstants.mainColor,
            border: Border.all(color: GlobalConstants.borderColor,width: 2),
            borderRadius: BorderRadius.circular(GlobalConstants.borderRadius)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Response',style: TextStyle(color: GlobalConstants.textColor),),
            GetBuilder<FreeCallController>(
              builder:(controller)=> Expanded(
                child:controller.isRequesting?
                    const Center(child: Text('Requesting...',style: TextStyle(color: GlobalConstants.textColor),),)
                    : Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  margin:const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: GlobalConstants.bgColor,
                      borderRadius: BorderRadius.circular(GlobalConstants.borderRadius)
                  ),
                  child: JsonEditorTheme(
                    themeData: JsonEditorThemeData(
                      darkTheme: JsonTheme(
                        bracketStyle:const TextStyle(color: GlobalConstants.textColor),
                      ),
                      lightTheme: JsonTheme(
                        bracketStyle:const TextStyle(color: GlobalConstants.textColor),
                      ),
                    ),
                    child: JsonEditor.string(
                      jsonString: freeCallController.response == null
                          ? ""
                          : freeCallController.response!.bodyString,
                      enabled: false,
                      onValueChanged: (value) {},
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }


  Widget allPanel() {
    return Container();
  }


}
