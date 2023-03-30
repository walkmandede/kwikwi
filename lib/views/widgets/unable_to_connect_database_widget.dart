
import 'package:flutter/material.dart';
import 'package:kwikwi/globals/global_constants.dart';

class UnableToConnectDatabaseWidget extends StatelessWidget {
  final String errorMessage;
  const UnableToConnectDatabaseWidget({Key? key,required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: GlobalConstants.bgColor
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Unable to connect database, something went wrong or please check your internet connection!',style: TextStyle(color: Colors.greenAccent),),
            const SizedBox(height: 10,),
            Text(errorMessage,style: TextStyle(color: Colors.redAccent),)
          ],
        ),
      ),
    );
  }
}
