import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:json_editor/json_editor.dart';

class JsonEditor extends StatelessWidget {
  const JsonEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController txtController = TextEditingController(text: '');
    Map<String,String> bracketsMap = {
      "{":"}",
      "[":"]",
    };

    Rx<bool> xValid = false.obs;

    String prettyJson(dynamic json) {
      var spaces = ' ' * 4;
      var encoder = JsonEncoder.withIndent(spaces);
      return encoder.convert(json);
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.blueGrey
        ),
        alignment: Alignment.center,
        child: Obx(
          () {
            return Container(
              height: Get.height * 0.5,
              width: Get.width * 0.6,
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
              padding: const EdgeInsets.all(20),
              child: RawKeyboardListener(
                onKey: (event) {
                  String text = txtController.text;
                  if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                    try{
                      Map data = jsonDecode(text);
                      xValid.value = true;
                      txtController.text = prettyJson(txtController.text);
                    }
                    catch(e){
                      xValid.value = false;
                      superPrint(e);
                    }
                  }
                },
                focusNode: FocusNode(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: txtController,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          // if(bracketsMap.keys.contains(value.characters.last)){
                          //   txtController.text = "${txtController.text}${bracketsMap[value]!}";
                          // }
                        },
                      ),
                    ),
                    xValid.value?Text('Valid',style: TextStyle(color: Colors.greenAccent),):
                        Text('Invalid json format',style: TextStyle(color: Colors.redAccent),)
                  ],
                ),
              ),
            );
          },

        ),
      ),
    );
  }
}
