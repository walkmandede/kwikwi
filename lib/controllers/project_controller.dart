
import 'package:get/get.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:kwikwi/controllers/call_controller.dart';
import 'package:kwikwi/models/kwikwi_project.dart';
import 'package:kwikwi/models/kwikwi_request.dart';
import 'package:kwikwi/services/mongo_services.dart';


class ProjectController extends GetxController{

  KwiKwiRequest currentRequest = KwiKwiRequest(
      requestId: '',
      projectId: '',
      collectionId: '',
      name: '',
      requestMethod: RequestMethod.get,
      requestUrl: '',
      requestHeaders: {},
      requestBody: {}
  );


  Map<String,KwiKwiProject> allProjects = {};
  Map<String,KwiKwiCollection> allCollections = {};
  Map<String,KwiKwiRequest> allRequests = {};

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> initLoad() async{
    await getAllProjects();
    await getAllCollections();
    await getAllRequests();
  }

  Future<void> getAllProjects() async{
    allProjects.clear();
    try{
      List<Map> allData = await MongoDatabase().getCollectionAllData(colName: MongoDatabase.colProjects);

      for (var value in allData) {
        KwiKwiProject kwiKwiProject = KwiKwiProject.fromDb(data: value);
        allProjects[kwiKwiProject.projectId] = kwiKwiProject;
      }
    }
    catch(e){
      superPrint(e);
    }
  }

  Future<void> getAllCollections() async{
    allCollections.clear();
    try{
      List<Map> allData = await MongoDatabase().getCollectionAllData(colName: MongoDatabase.colCollections);

      for (var value in allData) {
        KwiKwiCollection kwiKwiCollection = KwiKwiCollection.fromDb(data: value);
        allCollections[kwiKwiCollection.collectionId] = kwiKwiCollection;
      }
    }
    catch(e){
      superPrint(e);
    }
  }

  Future<void> getAllRequests() async{
    allRequests.clear();
    try{
      List<Map> allData = await MongoDatabase().getCollectionAllData(colName: MongoDatabase.colRequests);

      for (var value in allData) {
        KwiKwiRequest kwiKwiRequest = KwiKwiRequest.fromDb(data: value);
        allRequests[kwiKwiRequest.requestId] = kwiKwiRequest;
      }
    }
    catch(e){
      superPrint(e);
    }
  }

  Future<void> onClickRequest({required KwiKwiRequest kwiKwiRequest}) async{
    currentRequest = kwiKwiRequest;
    CallController callController = Get.find();
    callController.initLoad(request: kwiKwiRequest);
    callController.update();
    update();
  }

}