
import 'package:kwikwi/models/kwikwi_request.dart';

import '../services/mongo_services.dart';

class KwiKwiProject{

  String projectId;
  String name;
  String slug;

  KwiKwiProject({
    required this.projectId,
    required this.name,
    required this.slug,
  });

  factory KwiKwiProject.fromDb({required Map data}){

    return KwiKwiProject(
        projectId: MongoDatabase().idParser(data),
        name: data['name'].toString(),
        slug: data['slug'].toString(),
    );

  }

  Map<String,dynamic> convertToMap(){

    return {
      'name' : name,
      'slug' : slug,
    };
  }

}

class KwiKwiCollection{

  String collectionId;
  String projectId;
  String name;

  KwiKwiCollection({
    required this.collectionId,
    required this.projectId,
    required this.name
  });

  factory KwiKwiCollection.fromDb({required Map data}){

    return KwiKwiCollection(
      collectionId: MongoDatabase().idParser(data),
      projectId: data['projectId'].toString(),
      name: data['name'].toString(),
    );

  }

  Map<String,dynamic> convertToMap(){

    return {
      'name' : name,
      'projectId' : projectId,
    };
  }

}


