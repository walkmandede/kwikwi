import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:mongo_dart/mongo_dart.dart';


class MongoDatabase{

  static String colProjects = 'projects';
  static String colCollections = 'collections';
  static String colRequests = 'requests';
  static String colUsers = 'users';

  static Db db = Db('');

  String idParser(Map data){
    ObjectId objectId = data['_id'];
    return objectId.$oid;
  }

  static Future<void> connect() async{
    db = await Db.create('mongodb+srv://walkmandede:sio64ati7o@cluster0.qag8tm8.mongodb.net/kwikwi?retryWrites=true&w=majority');
    await db.open();
  }

  DbCollection getCollection({required String colName}){
    return db.collection(colName);
  }

  Future<List<Map>> getCollectionAllData({required String colName}) async{
    return await db.collection(colName).find().toList();
  }

  // Future<Map> findByObjectId({required String objectId}) async{
  //   DbCollection roomCollection = MongoDatabase().getCollection(colName: MongoDatabase.colRooms);
  //   List res = await roomCollection.find({"_id" : ObjectId.parse(objectId)}).toList();
  //   return res.first;
  // }

  Future<Map> deleteDocument({required String colName,required String objectId}) async{
    return await db.collection(colName).remove({"_id" : ObjectId.parse(objectId)});
  }

  Future<void> updateDocument({required String colName,required String objectId,required Map<String,dynamic> json}) async{
    await db.collection(colName).replaceOne({"_id" : ObjectId.parse(objectId)},json);
  }

  Future<WriteResult?> insertDataIntoCollection({required String colName,required Map<String,dynamic> data}) async{
    WriteResult? writeResult;
    try{
      DbCollection collection = MongoDatabase().getCollection(colName: colName);
      writeResult = await collection.insertOne(data);
    }
    catch(e){
      superPrint(e);
    }
    return writeResult;
  }

}