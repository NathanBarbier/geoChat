import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geo_chat/view/register_view.dart';
import 'package:lottie/lottie.dart';

class MyLoading extends StatefulWidget {
  const MyLoading({super.key});

  @override
  State<MyLoading> createState() => _MyLoadingState();
}

class _MyLoadingState extends State<MyLoading> {
  PageController pageController = PageController();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
      if (pageController.page == 2) {
        timer.cancel;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        children: [
          Center(
            child: Lottie.asset("assets/animation.json")
          ),
          Text("Deuxième page"),
          Text(""),
        ],
        controller: pageController,
        onPageChanged: (int page) {
          if (page == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyRegisterView()),
            );
          }
        },
      ),
    );
  }
}
