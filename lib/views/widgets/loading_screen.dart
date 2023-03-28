import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 3),

      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black
      ),
      child: const Center(
        child: CupertinoActivityIndicator(
          color: Colors.white,
          radius: 20,
        ),
      ),
    );
  }
}
