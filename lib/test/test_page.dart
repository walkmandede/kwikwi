// import 'dart:convert';
//
// import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:json_editor/json_editor.dart';
// import 'package:kwikwi/globals/global_constants.dart';
//
// class TestPage extends StatelessWidget {
//   const TestPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//    Get.put(TestController());
//     return Scaffold(
//       body: GetBuilder<TestController>(
//         builder: (controller) {
//           return Column(
//             children: [
//               Container(
//                 width: Get.width * 0.5,
//                 height: Get.width * 0.5,
//                 padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                 decoration: BoxDecoration(
//                   color: GlobalConstants.secondaryColor
//                 ),
//                 child: JsonEditorTheme(
//                   themeData: GlobalConstants().jsonTheme1,
//                   child: JsonEditor.object(
//                     object: controller.data,
//                     onValueChanged: (value) {
//                       controller.data = jsonDecode(value.toString());
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//       ),
//
//     );
//   }
// }