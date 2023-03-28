
import 'package:flutter/material.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:get/get.dart';
import 'package:kwikwi/globals/global_functions.dart';
import 'package:kwikwi/models/kwikwi_project.dart';
import 'package:kwikwi/services/mongo_services.dart';
import 'package:kwikwi/views/home_main_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;

import '../../controllers/global_controller.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({Key? key}) : super(key: key);

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {

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
          height: Get.height * 0.35,
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
                  const Text('Add Your Project',style: TextStyle(color: GlobalConstants.textColor,fontWeight: FontWeight.w600,fontSize: 16),)
                ],
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
                    hintText: 'Project Name',
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
    Map<String,dynamic> data = KwiKwiProject(
        projectId: '',
        name: textEditingController.text,
        slug: textEditingController.text
    ).convertToMap();
    showAlertDialog(content: 'Please Wait',xDismissible: false);
    md.WriteResult? writeResult = await MongoDatabase().insertDataIntoCollection(colName: MongoDatabase.colProjects, data: data);
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
