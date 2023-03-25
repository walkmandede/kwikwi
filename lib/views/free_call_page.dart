import 'package:flutter/cupertino.dart';
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
          IconButton(
            padding: EdgeInsets.zero,
              onPressed: ()async{
                await freeCallController.onClickSubmit();
              },
              icon:const Icon(Icons.send_rounded,color: GlobalConstants.iconColor,))
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
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding:const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: GlobalConstants.mainColor,
            border: Border.all(color: GlobalConstants.borderColor,width: 2),
            borderRadius: BorderRadius.circular(GlobalConstants.borderRadius)
        ),
        child: Column(
          children: [
            pageTapPanel(),
            widget,
          ],
        )
    );
  }

  Widget pageTapPanel(){
    return GetBuilder<FreeCallController>(
      builder:(controller)=> Row(
        mainAxisSize: MainAxisSize.min,
        children:PageTab.values.map((e) => Container(
          padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color:controller.pageTab==e?GlobalConstants.hightLightColor:Colors.transparent,width: 2.5))
          ),
          child: Text(e.name.toUpperCase()),
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
    FreeCallController freeCallController = Get.find();
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

        child: JsonEditor.string(
          jsonString: "",
          enabled: true,
          onValueChanged: (value) {
            freeCallController.kwiKwiRequest.body = value.toJson();
            freeCallController.update();
          },
        )
    );
  }

  Widget headerPanel() {
    return Container();
  }

  Widget responsePanel() {
    FreeCallController freeCallController = Get.find();
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(10)
        ),
        child: JsonEditorTheme(
          themeData: JsonEditorThemeData(
            darkTheme: JsonTheme(
                stringStyle:const TextStyle(color: Colors.greenAccent, fontSize: 10)
            ),
            lightTheme: JsonTheme(
                stringStyle:const TextStyle(color: Colors.greenAccent, fontSize: 14,)
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
    );
  }


  Widget allPanel() {
    return Container();
  }


}
