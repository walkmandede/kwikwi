
import 'package:kwikwi/models/kwikwi_request.dart';

class KwiKwiProject{

  String id;
  String name;
  String slug;
  List<KwiKwiCollection> collections;

  KwiKwiProject({
    required this.id,
    required this.name,
    required this.slug,
    required this.collections
  });



}

class KwiKwiCollection{

  String id;
  String name;
  List<KwiKwiRequest> requests;

  KwiKwiCollection({
    required this.id,
    required this.name,
    required this.requests
  });

}
