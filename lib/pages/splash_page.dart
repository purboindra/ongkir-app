import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkos_kirim_getx_10_mar/controller/home_controller.dart';
import 'package:ongkos_kirim_getx_10_mar/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
        const Duration(
          seconds: 3,
        ),
        () => Get.off(() => HomePage()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 238),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/icon.png'),
                ),
              ),
            ),
            Text(
              "Sometimes You Win, Sometimes You Learn",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
