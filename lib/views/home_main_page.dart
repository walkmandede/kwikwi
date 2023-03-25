

import 'package:flutter/material.dart';
import 'package:kwikwi/controllers/home_main_controller.dart';
import 'package:kwikwi/views/free_call_page.dart';
import 'package:kwikwi/views/widgets/side_bar.dart';
import 'package:get/get.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeMainController());
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child:  Row(
          children: const [
            HomeSideBar(),
            Expanded(child: FreeCallPage()),
          ],
        ),
      ),
    );
  }
}

