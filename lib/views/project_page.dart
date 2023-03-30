import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kwikwi/controllers/call_controller.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/models/kwikwi_project.dart';
import 'package:kwikwi/views/collection_page.dart';
import 'package:kwikwi/views/create/add_project_page.dart';
import 'package:kwikwi/views/widgets/not_full_screen_widget.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProjectController());
    Get.put(CallController());
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: screenSize.width<1000?const NotFullScreenWidget():Row(
          children: [
            projectBar(),
            const Expanded(child: CollectionPage())
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
          color: GlobalConstants.mainColor,
          border: Border(right: BorderSide(color: GlobalConstants.borderColor,width: GlobalConstants.borderWidth))
      ),
      child: Column(
        children: [
          //App Name
          Container(
             width: double.maxFinite,
              height: Get.height*0.085,
              alignment: Alignment.center,
              child: Text('Kwikwi Postman',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: Colors.white,fontWeight:FontWeight.bold),)),
          Container(
            width: double.maxFinite,
            padding:const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Projects',style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: GlobalConstants.textColor)),
                IconButton(
                    onPressed: (){
                      Get.to(const AddProjectPage());
                    },
                    icon: const Icon(Iconsax.add,color:GlobalConstants.hightLightColor, size: 20,),)
              ],
            ),
          ),
          Expanded(
              child: projectListPanel())
        ],
      ),
    );

  }

  Widget projectListPanel(){
    return GetBuilder<ProjectController>(
        builder: (controller)=>
            controller.allProjects.isNotEmpty?
            ListView.builder(
          itemCount: controller.allProjects.length,
          itemBuilder: (context,index) {
            String key = controller.allProjects.keys.toList()[index];
            KwiKwiProject currentProject = controller.allProjects[key]!;
            return eachProject(currentProject);
          },
        ):Container()
    );
  }

  Widget eachProject(KwiKwiProject project){
    return GetBuilder<ProjectController>(
      builder:(controller)=> GestureDetector(
        onTap: (){
          controller.onClickProject(project);
        },
        child: Container(
          width: double.maxFinite,
          padding:const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
          decoration: BoxDecoration(
            border:Border(left: BorderSide(color:controller.currentProject!.projectId==project.projectId? GlobalConstants.hightLightColor:Colors.transparent,width: 2.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Iconsax.folder,color:controller.currentProject!.projectId==project.projectId?Colors.white: GlobalConstants.iconColor,),
              const SizedBox(width: 25,),
              Text(project.name,maxLines: 1,style:Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:controller.currentProject!.projectId==project.projectId?Colors.white: GlobalConstants.textColor) ,)
            ],
          ),
        ),
      ),
    );
  }



  // Widget projectBar(){
  //   return Container(
  //     width: Get.width * 0.2,
  //     height: double.infinity,
  //     decoration: const BoxDecoration(
  //       color: GlobalConstants.mainColor,
  //       border: Border(right: BorderSide(color: GlobalConstants.borderColor,width: GlobalConstants.borderWidth))
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
  //     child: Column(
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             Get.to(()=> const AddProjectPage());
  //           },
  //           child: Container(
  //             decoration: const BoxDecoration(
  //               color: Colors.transparent
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: const [
  //                 Text('Add New Project',style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.w600),),
  //                 Icon(Icons.add_circle,color: Colors.greenAccent,)
  //               ],
  //             ),
  //           ),
  //         ),
  //         const Padding(
  //           padding: EdgeInsets.symmetric(vertical: 10),
  //           child: Divider(color: GlobalConstants.iconColor,thickness: 1.5,),
  //         ),
  //         Expanded(
  //           child: GetBuilder<ProjectController>(
  //             builder: (controller) {
  //               return Container(
  //                 margin: const EdgeInsets.symmetric(vertical: 20),
  //                 child: ListView.builder(
  //                   itemCount: controller.allProjects.length,
  //                   itemBuilder: (context, index) {
  //                     KwiKwiProject kwiKwiProject = controller.allProjects.values.toList()[index];
  //                     return ExpansionTile(
  //                       title: Text(kwiKwiProject.name,style: const TextStyle(color: GlobalConstants.projectColor),),
  //                       iconColor: GlobalConstants.projectColor,
  //                       trailing: IconButton(
  //                         onPressed: () {
  //                           Get.to(()=> AddCollectionPage(kwiKwiProject: kwiKwiProject));
  //                         },
  //                         icon: const Icon(Icons.add_circle,color: GlobalConstants.projectColor,),
  //                       ),
  //                       children: controller.allCollections.values.where((element) => element.projectId == kwiKwiProject.projectId).map((e) {
  //                         KwiKwiCollection kwikwiCollection = controller.allCollections.values.toList()[index];
  //                         return Container(
  //                           padding: const EdgeInsets.symmetric(horizontal: 12),
  //                           child: ExpansionTile(
  //                             title: Text(kwikwiCollection.name,style: const TextStyle(color: GlobalConstants.collectionColor,fontSize: 12),),
  //                             iconColor: GlobalConstants.collectionColor,
  //                             trailing: IconButton(
  //                               onPressed: () {
  //                                 Get.to(()=> AddRequestPage(kwiKwiProject: kwiKwiProject,kwiKwiCollection: kwikwiCollection,));
  //                               },
  //                               icon: const Icon(Icons.add_circle,color: GlobalConstants.collectionColor,),
  //                             ),
  //                             children: controller.allRequests.values.where((element) => element.collectionId == kwikwiCollection.collectionId).map((e) {
  //                               bool xSelected = controller.currentRequest.requestId == e.requestId;
  //                               return GestureDetector(
  //                                 onTap: () async{
  //                                   await controller.onClickRequest(kwiKwiRequest: e);
  //                                 },
  //                                 child: Container(
  //                                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
  //                                   decoration: BoxDecoration(
  //                                     color: !xSelected?Colors.transparent:Colors.black26,
  //                                     borderRadius: BorderRadius.circular(6)
  //                                   ),
  //                                   alignment: Alignment.centerLeft,
  //                                   child: Text(e.name,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600,color: GlobalConstants.requestColor),),
  //                                 ),
  //                               );
  //                             }).toList(),
  //                           ),
  //                         );
  //                       }).toList(),
  //                     );
  //                   },
  //                 ),
  //               );
  //             },
  //           )
  //         )
  //       ],
  //     ),
  //   );
  // }

}
