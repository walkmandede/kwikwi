import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kwikwi/controllers/call_controller.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/models/kwikwi_project.dart';
import 'package:kwikwi/views/create/add_collection_page.dart';
import 'package:kwikwi/views/create/add_project_page.dart';
import 'package:kwikwi/views/create/add_request_page.dart';

import 'call_page.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProjectController());
    Get.put(CallController());
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            projectBar(),
            // Expanded(
            //   child: GetBuilder<CallController>(
            //     builder: (controller) {
            //       return CallPage(kwiKwiRequest: controller.kwiKwiRequest,);
            //     },
            //   )
            // )
          ],
        ),
      ),
    );
  }

  Widget projectBar(){
    return Container(
      width: Get.width * 0.2,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: GlobalConstants.secondaryColor
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(()=> const AddProjectPage());
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Add New Project',style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.w600),),
                  Icon(Icons.add_circle,color: Colors.greenAccent,)
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: GlobalConstants.iconColor,thickness: 1.5,),
          ),
          Expanded(
            child: GetBuilder<ProjectController>(
              builder: (controller) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    itemCount: controller.allProjects.length,
                    itemBuilder: (context, index) {
                      KwiKwiProject kwiKwiProject = controller.allProjects.values.toList()[index];
                      return ExpansionTile(
                        title: Text(kwiKwiProject.name,style: const TextStyle(color: GlobalConstants.projectColor),),
                        iconColor: GlobalConstants.projectColor,
                        trailing: IconButton(
                          onPressed: () {
                            Get.to(()=> AddCollectionPage(kwiKwiProject: kwiKwiProject));
                          },
                          icon: const Icon(Icons.add_circle,color: GlobalConstants.projectColor,),
                        ),
                        children: controller.allCollections.values.where((element) => element.projectId == kwiKwiProject.projectId).map((e) {
                          KwiKwiCollection kwikwiCollection = controller.allCollections.values.toList()[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ExpansionTile(
                              title: Text(kwikwiCollection.name,style: const TextStyle(color: GlobalConstants.collectionColor,fontSize: 12),),
                              iconColor: GlobalConstants.collectionColor,
                              trailing: IconButton(
                                onPressed: () {
                                  Get.to(()=> AddRequestPage(kwiKwiProject: kwiKwiProject,kwiKwiCollection: kwikwiCollection,));
                                },
                                icon: const Icon(Icons.add_circle,color: GlobalConstants.collectionColor,),
                              ),
                              children: controller.allRequests.values.where((element) => element.collectionId == kwikwiCollection.collectionId).map((e) {
                                bool xSelected = controller.currentRequest.requestId == e.requestId;
                                return GestureDetector(
                                  onTap: () async{
                                    await controller.onClickRequest(kwiKwiRequest: e);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    decoration: BoxDecoration(
                                      color: !xSelected?Colors.transparent:Colors.black26,
                                      borderRadius: BorderRadius.circular(6)
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(e.name,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600,color: GlobalConstants.requestColor),),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                );
              },
            )
          )
        ],
      ),
    );
  }

}
