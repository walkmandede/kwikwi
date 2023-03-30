import 'package:flutter/material.dart';
import 'package:json_editor/json_editor.dart';

class GlobalConstants{
  static const String appVersion = '1';

  static const String spEmail = 'spEmail';
  static const String spPassword = 'spPassword';

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
    lightTheme: JsonTheme(
      stringStyle:const TextStyle(color: Colors.lightGreenAccent, fontSize: 16,),
      boolStyle:const TextStyle(color: Colors.purpleAccent, fontSize: 16,),
      keyStyle:const TextStyle(color: Colors.grey,fontSize: 16),
      bracketStyle: const TextStyle(color: Colors.orangeAccent,fontSize: 16),
      numberStyle: const TextStyle(color: Colors.lightBlueAccent,fontSize: 16),
      defaultStyle: const TextStyle(color: Colors.lightBlueAccent,fontSize: 16),
    ),
    darkTheme: JsonTheme(
      stringStyle:const TextStyle(color: Colors.lightGreenAccent, fontSize: 16,),
      boolStyle:const TextStyle(color: Colors.purpleAccent, fontSize: 16,),
      keyStyle:const TextStyle(color: Colors.grey,fontSize: 16),
      bracketStyle: const TextStyle(color: Colors.orangeAccent,fontSize: 16),
      numberStyle: const TextStyle(color: Colors.lightBlueAccent,fontSize: 16),
      defaultStyle: const TextStyle(color: Colors.lightBlueAccent,fontSize: 16),
    ),
  );

  // var wordsStyle1 = {
  //   "{" : HighlightedWord(
  //     textStyle: const TextStyle(color: Colors.orangeAccent),
  //   ),
  //   "}" : HighlightedWord(
  //     textStyle: const TextStyle(color: Colors.orangeAccent),
  //   ),
  //   "[" : HighlightedWord(
  //     textStyle: const TextStyle(color: Colors.yellowAccent),
  //   ),
  //   "]" : HighlightedWord(
  //     textStyle: const TextStyle(color: Colors.yellowAccent),
  //   ),
  //   "true" : HighlightedWord(
  //     textStyle: const TextStyle(color: Colors.greenAccent),
  //   ),
  //   "false" : HighlightedWord(
  //     textStyle: const TextStyle(color: Colors.redAccent),
  //   ),
  //   ":" : HighlightedWord(
  //     textStyle: const TextStyle(color: Colors.grey),
  //   ),
  // };

}