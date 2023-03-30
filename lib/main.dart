import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikwi/controllers/global_controller.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/services/mongo_services.dart';
import 'package:kwikwi/views/auth/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await firstLoading();
  runApp(const MyApp());
}

Future<void> firstLoading() async{
  //initiateControllers
  Get.put(GlobalController());
  Get.put(ProjectController());
  await MongoDatabase.connect();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        textTheme:const TextTheme(
          bodySmall: TextStyle(fontSize: 14,color: GlobalConstants.textColor),
          bodyMedium: TextStyle(fontSize: 16,color: GlobalConstants.textColor),
          bodyLarge: TextStyle(fontSize: 20,color: GlobalConstants.textColor)
        )
      ),
      home: const LoginPage(),
    );
  }
}

