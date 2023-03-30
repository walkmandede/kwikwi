
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:kwikwi/globals/global_constants.dart';

class NotFullScreenWidget extends StatelessWidget {
  const NotFullScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: GlobalConstants.bgColor,
      ),
      alignment: Alignment.center,
      child: const Text('Please use in full screen mode, coz we were too lazy building responsive layout. :D',style: TextStyle(color: GlobalConstants.projectColor),)
    );
  }
}
