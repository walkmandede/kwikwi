import 'package:flutter/material.dart';
import 'package:json_editor/json_editor.dart';

class GlobalConstants{

  static const Color mainColor = Color(0xFF1e1f23);
  static const Color secondaryColor = Color(0xFF27282f);
  static const Color bgColor =  Color(0xFF17181c);
  static const Color borderColor =  Color(0xFF212327);
  static Color secondaryBorderColor = Colors.white.withOpacity(0.1);
  static const Color iconColor = Color(0xFF97999d);
  static const Color textColor = Color(0xFF97999d);
  static const Color hightLightColor = Color(0xFFFCA12F);

  static const double borderRadius = 5;
  static const double borderWidth = 2;
  static const double fontSize = 14;

  static const Color projectColor = Colors.lightBlueAccent;
  static const Color collectionColor = Colors.orangeAccent;
  static const Color requestColor = Colors.purpleAccent;


  var jsonTheme1 = JsonEditorThemeData(
    darkTheme: JsonTheme(
        stringStyle:const TextStyle(color: Colors.redAccent, fontSize: 10)
    ),
    lightTheme: JsonTheme(
      stringStyle:const TextStyle(color: Colors.lightGreenAccent, fontSize: 10,),
      boolStyle:const TextStyle(color: Colors.purpleAccent, fontSize: 10,),
      keyStyle:const TextStyle(color: Colors.grey,fontSize: 10),
      bracketStyle: const TextStyle(color: Colors.orangeAccent,fontSize: 10),
    ),
  );



}