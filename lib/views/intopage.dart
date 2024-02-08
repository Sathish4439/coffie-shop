import 'dart:async';

import 'package:coffie_shop/views/Mainpage.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class Intropage extends StatefulWidget {
  const Intropage({super.key});

  @override
  State<Intropage> createState() => _IntropageState();
}

class _IntropageState extends State<Intropage> {
  @override
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Mainpage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Lottie.network(
          "https://lottie.host/81529527-a8b2-4f4c-b9d2-c322cb2ebec1/FK6Upvyq1S.json"),
    ));
  }
}