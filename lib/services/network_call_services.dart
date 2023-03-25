
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:kwikwi/models/kwikwi_request.dart';

class NetworkCallServices{

  GetConnect getClient = GetConnect(timeout: const Duration(seconds: 200));

  Future<Response?> getCall({required KwiKwiRequest request}) async{
    Response? response;

    try{
      response = await getClient.get(
        request.url,
        headers: request.headers,
      );
    }
    catch(e){
      null;
    }

    return response;

  }

  Future<Response?> postCall({required KwiKwiRequest request}) async{
    Response? response;

    try{
      response = await getClient.post(
        request.url,
        request.body,
        headers: request.headers,
      );
    }
    catch(e){
      null;
    }
    return response;
  }

}