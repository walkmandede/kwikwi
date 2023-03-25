
enum RequestMethod{
  get,
  post,
  put,
  delete
}

class KwiKwiRequest{

  String id;
  RequestMethod requestMethod;
  String url;
  Map<String,String> headers;
  Map<String,dynamic> body;

  KwiKwiRequest({
    required this.id,
    required this.requestMethod,
    required this.url,
    required this.headers,
    required this.body
  });

}