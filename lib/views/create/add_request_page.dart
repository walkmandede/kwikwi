
import 'package:flutter/material.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:get/get.dart';
import 'package:kwikwi/globals/global_functions.dart';
import 'package:kwikwi/models/kwikwi_project.dart';
import 'package:kwikwi/models/kwikwi_request.dart';
import 'package:kwikwi/services/mongo_services.dart';
import 'package:kwikwi/views/home_main_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;

import '../../controllers/global_controller.dart';

class AddRequestPage extends StatefulWidget {
  final KwiKwiProject kwiKwiProject;
  final KwiKwiCollection kwiKwiCollection;
  const AddRequestPage({Key? key,required this.kwiKwiProject,required this.kwiKwiCollection}) : super(key: key);

  @override
  State<AddRequestPage> createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage> {

  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: GlobalConstants.bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 50),
        alignment: Alignment.center,
        child: Container(
          width: Get.width * 0.35,
          height: Get.height * 0.45,
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          decoration: BoxDecoration(
            color: GlobalConstants.mainColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.grey,)),
                  const Text('Add Your Request',style: TextStyle(color: GlobalConstants.textColor,fontWeight: FontWeight.w600,fontSize: 14),)
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  enabled: false,
                  controller: TextEditingController(text: widget.kwiKwiProject.name),
                  style: const TextStyle(color: GlobalConstants.projectColor),
                  decoration: const InputDecoration(
                      label: Text('Project',style: TextStyle(color: Colors.grey),),
                      border: InputBorder.none
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  enabled: false,
                  controller: TextEditingController(text: widget.kwiKwiCollection.name),
                  style: const TextStyle(color: GlobalConstants.collectionColor),
                  decoration: const InputDecoration(
                      label: Text('Collection',style: TextStyle(color: Colors.grey),),
                      border: InputBorder.none
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: GlobalConstants.secondaryColor,
                    borderRadius: BorderRadius.circular(6)
                ),
                child: TextField(
                  controller: textEditingController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Request Name',
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async{
                    await onClickSave();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => GlobalConstants.hightLightColor),
                  ),
                  child: const Text('Save',style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onClickSave() async {
    Map<String,dynamic> data = KwiKwiRequest(
      projectId: widget.kwiKwiProject.projectId,
      name: textEditingController.text,
      collectionId: widget.kwiKwiCollection.collectionId,
      requestId: '',
      requestHeaders: {
        "content-type": "application/json; charset=utf-8"
      },
      requestMethod: RequestMethod.get,
      requestBody: {

      },
      requestUrl: ''
    ).convertToMap();
    showAlertDialog(content: 'Please Wait',xDismissible: false);
    md.WriteResult? writeResult = await MongoDatabase().insertDataIntoCollection(colName: MongoDatabase.colRequests, data: data);
    try{
      if(writeResult!.isSuccess){
        ProjectController projectController = Get.find();
        await projectController.initLoad();
        Get.back();
        showAlertDialog(content: 'Successfully Created');
        Get.offAll(()=> const HomeMainPage());
      }
      else{
        Get.back();
        showAlertDialog(content: 'Something went wrong!');
      }
    }
    catch(e){
      Get.back();
      showAlertDialog(content: 'Something went wrong!');
    }

  }
}
