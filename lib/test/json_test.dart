import 'package:flutter/services.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:json_editor/json_editor.dart';

class JsonTest extends StatelessWidget {
  const JsonTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController txtController = TextEditingController(text: '');
    Map<String,String> bracketsMap = {
      "{":"}",
      "[":"]",
    };

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueGrey
        ),
        alignment: Alignment.center,
        child: Container(
          height: Get.height * 0.5,
          width: Get.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.white
          ),
          padding: const EdgeInsets.all(20),
          child: RawKeyboardListener(
            onKey: (event) {
              String text = txtController.text;
              if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                // if(bracketsMap.keys.contains(text)){
                //   txtController.text = "${txtController.text}${bracketsMap[text]!}";
                // }
              }
            },
            focusNode: FocusNode(),
            child: TextField(
              controller: txtController,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if(bracketsMap.keys.contains(value.characters.last)){
                  txtController.text = "${txtController.text}${bracketsMap[value]!}";
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
