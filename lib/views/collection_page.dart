import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/models/kwikwi_project.dart';
import 'package:kwikwi/models/kwikwi_request.dart';
import 'dart:math' as math;

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.maxFinite,
      height: double.maxFinite,
      color: GlobalConstants.bgColor,
      child: bodyWidget(),
    );
  }

  Widget bodyWidget(){
    return Column(
      children: [
        topPanel(),
        recentPanel(),
        collectionPanel(),
        Expanded(child: requestPanel()),
      ],
    );
  }

  Widget topPanel(){
    return Container(
       width: double.maxFinite,
        height: Get.height*0.085,
      padding:const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerRight,
      decoration:const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(color: GlobalConstants.borderColor,width: GlobalConstants.borderWidth)
          )
      ),
      child: Container(
        width: Get.width*0.25,
        padding:const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: GlobalConstants.secondaryColor,
          borderRadius: BorderRadius.circular(GlobalConstants.borderRadius)
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                cursorColor: GlobalConstants.iconColor,
                style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for collections',
                  hintStyle: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: GlobalConstants.iconColor.withOpacity(0.5)),
                ),
              ),
            ),
            const Icon(Iconsax.search_normal,color: GlobalConstants.iconColor,size: 18,)
          ],
        ),
      ),
    );
  }

  Widget recentPanel(){
    return Container(
      width: double.maxFinite,
      padding:const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent requests',style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: GlobalConstants.textColor),),
          const SizedBox(height: 15,),
          SizedBox(
            height: Get.width*0.1,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context,index)=>requestWidget(KwiKwiRequest(requestId: '', projectId: '', collectionId: '', name: 'Test Request', requestMethod: RequestMethod.get, requestUrl: '', requestHeaders: {}, requestBody: {}))),
          )
        ],
      ),
    );
  }

  Widget requestWidget(KwiKwiRequest request){
    Color methodColor;
    switch(request.requestMethod) {
      case RequestMethod.get:
        methodColor = const Color(0xFF48CD8F);
        break;
      case RequestMethod.post:
        methodColor = const Color(0xFFFCA12F);
        break;
      case RequestMethod.put:
        methodColor = const Color(0xFF62AFFF);
        break;
      case RequestMethod.delete:
        methodColor = Color(0xFFF93E3D);
        break;
    }
    return Container(
      width: Get.width*0.1,
      height: Get.width*0.1,
      margin:const EdgeInsets.only(right: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: GlobalConstants.mainColor,
        borderRadius: BorderRadius.circular(GlobalConstants.borderRadius)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:const EdgeInsets.all(15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: GlobalConstants.secondaryColor,
            ),
            child: Text(
              request.requestMethod.name.toUpperCase(),style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: methodColor),
            ),

          ),
          const SizedBox(height: 15,),
          Text(request.name,style: Theme.of(Get.context!).textTheme.bodySmall!,)
        ],
      ),
    );
  }

  Widget collectionPanel(){
    return GetBuilder<ProjectController>(
      builder:(controller){
        List<KwiKwiCollection> collectionList=[];
        if(controller.currentProject!=null) {
         collectionList = controller.allCollections
              .values.where((collection) =>
          collection.projectId == controller.currentProject!.projectId).toList();
        }
        return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Collections',style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: GlobalConstants.textColor),),
            const SizedBox(height: 15,),
            SizedBox(
                height: Get.width*0.03,
                child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                    itemCount: collectionList.length,
                    itemBuilder: (context,index)=>eachCollectionWidget(collectionList[index])))
          ],
        ),
      );
      }
    );
  }

  Widget eachCollectionWidget(KwiKwiCollection collection){
    const List<Color> colorList = [
      Color(0xFF48CD8F),
      Color(0xFFFCA12F),
      Color(0xFF62AFFF),
      Color(0xFFF93E3D)
    ];
    Color currentColor = colorList[math.Random().nextInt(colorList.length - 1)];
    return GetBuilder<ProjectController>(
      builder:(controller) {
        bool isClicked = controller.currentCollection!.collectionId==collection.collectionId;
        return GestureDetector(
        onTap: () {
          controller.currentCollection = collection;
          controller.update();
        },
        child: Container(
          width: Get.width * 0.125,
          height: Get.width * 0.03,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
              color:isClicked?currentColor:Colors.transparent,
              borderRadius: BorderRadius.circular(GlobalConstants.borderRadius),
            border: Border.all(color:currentColor,width: GlobalConstants.borderWidth)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.folder_2, color:isClicked? Colors.white:currentColor,),
              const SizedBox(width: 10,),
              Text(collection.name, style: Theme
                  .of(Get.context!)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color:isClicked? Colors.white:GlobalConstants.textColor),)
            ],
          ),
        ),
      );
      }
    );
  }

  Widget requestPanel(){
    return GetBuilder<ProjectController>(
      builder:(controller){
        List<KwiKwiRequest> requestList = [];
        if(controller.currentCollection!=null){
          requestList = controller.allRequests.values.where((request) => request.collectionId==controller.currentCollection!.collectionId).toList();
        }

        return requestList.isNotEmpty? Container(
          width: double.maxFinite,
          padding:const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Requests',style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: GlobalConstants.textColor),),
              const SizedBox(height: 15,),
              Expanded(
                  child:GridView.builder(
                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,childAspectRatio: 1),
                      itemCount: requestList.length,
                      itemBuilder: (context,index)=>requestWidget(requestList[index]))
              )

            ],

          ),
        ):Container();
      }
    );
  }
}
