import '../services/mongo_services.dart';

class KwiKwiUser{

  String id;
  String email;
  String password;

  KwiKwiUser({
    required this.id,
    required this.email,
    required this.password,
  });

  factory KwiKwiUser.fromDb({required Map data}){

    return KwiKwiUser(
      id: MongoDatabase().idParser(data),
      email: data['email'].toString(),
      password: data['password'].toString()
    );

  }

  Map<String,dynamic> convertToMap(){

    return {
      'email' : email,
      'password' : password,
    };
  }

}