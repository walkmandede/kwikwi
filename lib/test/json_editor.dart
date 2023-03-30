import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:json_editor/json_editor.dart';
import 'package:json_pretty/json_pretty.dart';

class JsonEditor extends StatelessWidget {
  const JsonEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController txtController = TextEditingController(text: '');
    Map<String,String> bracketsMap = {
      "{":"}",
      "[":"]",
    };

    int lti = 0;

    Rx<bool> xValid = false.obs;

    // String prettyJson(dynamic json) {
    //   var spaces = ' ' * 4;
    //   var encoder = JsonEncoder.withIndent(spaces);
    //   return encoder.convert(json);
    // }

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
                  List chars = [];

                  chars.addAll(text.characters.toList());

                  String newText = '';
                  if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                    String lastTypeCharacter = text.characters.toList()[lti-1];

                    if(bracketsMap.keys.contains(lastTypeCharacter)){
                      String newCharacter = bracketsMap[lastTypeCharacter]!;
                      superPrint(chars);
                      chars.insert(text.characters.length, newCharacter);
                    }

                    superPrint(chars);

                    chars.forEach((element) {
                      newText = newText + element;
                    });

                    txtController.text = newText;

                    try{
                      Map data = jsonDecode(text);
                      xValid.value = true;

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
                          lti = txtController.selection.start;
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
