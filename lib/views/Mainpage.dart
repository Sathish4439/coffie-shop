import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart.dart';
import 'fav.dart';
import 'homepgae.dart';
import 'setting.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  List pages = [Home(), fav(), Cart(), Settings()];

  int selectedindex = 0;
  bool bold = false;

  void changepage(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {},
      //       icon: IconButton(
      //           onPressed: () {
      //             Get.to(Mainpage());
      //           },
      //           icon: Icon(Icons.arrow_back_ios_new))),
      //   title: Text(
      //     "Coffie Shop",
      //     style: GoogleFonts.poppins(
      //         fontWeight: FontWeight.bold, color: Colors.black),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: GestureDetector(
      //         onTap: () {
      //           Get.to(Settings());
      //         },
      //         child: Hero(
      //             transitionOnUserGestures: true,
      //             tag: "profile",
      //             child: Icon(
      //               Icons.person,
      //               size: 30,
      //             )),
      //       ),
      //     )
      //   ],
      // ),

      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedindex,
          onTap: changepage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined), label: "favorite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: "cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: "settings"),
          ]),
      body: pages[selectedindex],
    );
  }
}
