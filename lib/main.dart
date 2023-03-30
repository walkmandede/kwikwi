import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kwikwi/controllers/global_controller.dart';
import 'package:kwikwi/controllers/project_controller.dart';
import 'package:kwikwi/globals/global_constants.dart';
import 'package:kwikwi/services/mongo_services.dart';
import 'package:kwikwi/views/auth/login_page.dart';
import 'package:kwikwi/views/widgets/loading_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await firstLoading();
  runApp(const MyApp());
}

Future<void> firstLoading() async{
  //initiateControllers
  Get.put(GlobalController());
  Get.put(ProjectController());
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
          fontFamily: 'Poppins',
          textTheme:const TextTheme(
          bodySmall: TextStyle(fontSize: 14,color: GlobalConstants.textColor),
          bodyMedium: TextStyle(fontSize: 16,color: GlobalConstants.textColor),
          bodyLarge: TextStyle(fontSize: 20,color: GlobalConstants.textColor)
        )
      ),
      home: const GateWayPage(),
    );
  }
}

class GateWayPage extends StatefulWidget {
  const GateWayPage({Key? key}) : super(key: key);

  @override
  State<GateWayPage> createState() => _GateWayPageState();
}

class _GateWayPageState extends State<GateWayPage> {

  Rx<bool> xLoading = true.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initLoad();
  }

  Future<void> initLoad() async{
    try{
      await MongoDatabase.connect();
    }
    catch(e){
      null;
    }
    xLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if(xLoading.value){
        return const LoadingScreen();
      }
      else{
        return const LoginPage();
      }
    });
  }
}


