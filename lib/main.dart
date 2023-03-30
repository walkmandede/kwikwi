import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikwi/controllers/global_controller.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/models/kwikwi_request.dart';
import 'package:kwikwi/services/mongo_services.dart';
import 'package:kwikwi/test/json_editor.dart';
import 'package:kwikwi/test/json_test.dart';
import 'package:kwikwi/test/test_page.dart';
import 'package:kwikwi/views/auth/login_page.dart';
import 'package:kwikwi/views/create/add_project_page.dart';
import 'package:kwikwi/views/call_page.dart';
import 'package:kwikwi/views/home_main_page.dart';
import 'package:resizable_widget/resizable_widget.dart';

import 'controllers/call_controller.dart';

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
        primarySwatch: Colors.lightBlue
      ),
      home: const LoginPage(),
      // home: CallPage(
      //     kwiKwiRequest: KwiKwiRequest(
      //       collectionId: '',
      //       requestId: '',
      //       projectId: '',
      //       requestUrl: '',
      //       requestBody: {},
      //       requestHeaders: {},
      //       requestMethod: RequestMethod.get,
      //       name: ''
      //     )
      // ),
    );
  }
}


class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ResizableWidget(
        isHorizontalSeparator: true,
        separatorColor: Colors.blue,
        separatorSize: 10,
        children: [
          Container(color: Colors.greenAccent),
          ResizableWidget(
            children: [
              Container(color: Colors.greenAccent),
              Container(color: Colors.yellowAccent),
              Container(color: Colors.redAccent),
            ],
            percentages: const [0.2, 0.5, 0.3],
          ),
          Container(color: Colors.redAccent),
        ],
      ),
    );
  }
}
