
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:kwikwi/models/kwikwi_request.dart';

class NetworkCallServices{

  GetConnect getClient = GetConnect(timeout: const Duration(seconds: 200));

  Future<Response?> getCall({required KwiKwiRequest request}) async{
    Response? response;

    try{
      response = await getClient.get(
        request.requestUrl,
        headers: Map<String,String>.from(request.requestHeaders),
      );
    }
    catch(e){
      superPrint(e);
    }

    return response;

  }

  Future<Response?> postCall({required KwiKwiRequest request}) async{
    Response? response;

    try{
      response = await getClient.post(
        request.requestUrl,
        request.requestBody,
        headers: request.requestHeaders as Map<String,String>,
      );
    }
    catch(e){
      null;
    }
    return response;
  }

}