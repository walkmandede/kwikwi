import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikwi/controllers/global_controller.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/services/mongo_services.dart';
import 'package:kwikwi/views/auth/login_page.dart';
import 'package:resizable_widget/resizable_widget.dart';

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
