
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:kwikwi/models/kwikwi_request.dart';

class NetworkCallServices{

  GetConnect getClient = GetConnect(timeout: const Duration(seconds: 200));

  Future<Response?> getCall({required KwiKwiRequest request}) async{
    Response? response;

    Map<String,String> header = {
      'Access-Control-Allow-Origin': '*',
      'Accept': '*/*',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    request.requestHeaders.forEach((key, value) {
      header[key] = value;
    });

    try{
      response = await getClient.get(
        request.requestUrl,
        headers: header,
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
        headers: Map<String,String>.from(request.requestHeaders),
      );
    }
    catch(e){
      superPrint(e);
    }
    return response;
  }

  Future<Response?> putCall({required KwiKwiRequest request}) async{
    Response? response;
    try{
      superPrint(request.requestBody,title: request.requestUrl);
      response = await getClient.put(
        request.requestUrl,
        request.requestBody,
        headers: Map<String,String>.from(request.requestHeaders),
      );
    }
    catch(e){
      superPrint(e);
    }
    return response;
  }

  Future<Response?> deleteCall({required KwiKwiRequest request}) async{
    Response? response;
    try{
      superPrint(request.requestBody,title: request.requestUrl);
      response = await getClient.delete(
        request.requestUrl,
        headers: Map<String,String>.from(request.requestHeaders),
      );
    }
    catch(e){
      superPrint(e);
    }
    return response;
  }

}