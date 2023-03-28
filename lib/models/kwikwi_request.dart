
import '../services/mongo_services.dart';

enum RequestMethod{
  get,
  post,
  put,
  delete
}

class KwiKwiRequest{

  String requestId;
  String projectId;
  String collectionId;
  String name;
  RequestMethod requestMethod;
  String requestUrl;
  Map<String,dynamic> requestHeaders;
  Map<String,dynamic> requestBody;

  KwiKwiRequest({
    required this.requestId,
    required this.projectId,
    required this.collectionId,
    required this.name,
    required this.requestMethod,
    required this.requestUrl,
    required this.requestHeaders,
    required this.requestBody
  });

  factory KwiKwiRequest.fromDb({required Map data}){

    return KwiKwiRequest(
      requestId: MongoDatabase().idParser(data),
      projectId: data['projectId'].toString(),
      collectionId: data['collectionId'].toString(),
      name: data['name'].toString(),
      requestUrl: data['requestUrl'].toString(),
      requestHeaders: data['requestHeaders'],
      requestBody: data['requestBody'],
      requestMethod: RequestMethod.values.where((element) => element.name == data['requestMethod'].toString()).first
    );

  }

  Map<String,dynamic> convertToMap(){

    return {
      'name' : name,
      'projectId' : projectId,
      'collectionId' : collectionId,
      'requestUrl' : requestUrl,
      'requestHeaders' : requestHeaders,
      'requestBody' : requestBody,
      'requestMethod' : requestMethod.name
    };
  }

}