// ignore_for_file: unused_import

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/BookCategory.dart';
import 'package:bookstore_app/screens/cart.dart';
import 'package:bookstore_app/screens/homeScreen.dart';
import 'package:bookstore_app/screens/profile.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  int visit = 0; // Index of the selected tab

  final List<TabItem> items = [
    TabItem(
      icon: Icons.home_outlined,
      title: "Home",
    ),
    TabItem(
      icon: Icons.shopping_cart_outlined,
      title: "Cart",
    ),
    TabItem(
      icon: Icons.person_outline,
      title: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BottomBarFloating(
        items: items,
        borderRadius: BorderRadius.circular(20),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        colorSelected: primaryColor,
        color: primaryColor,
        indexSelected: visit,
        paddingVertical: 15,
        animated: false,
        enableShadow: true,
        iconSize: 20,
        onTap: (index) {
          setState(() {
            visit = index;
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Homescreen(),
                ),
              ).then((_) {
                setState(() {
                  visit = 0;
                });
              });
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(),
                ),
              ).then((_) {
                setState(() {
                  visit = 0;
                });
              });
            }
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              ).then((_) {
                setState(() {
                  visit = 0;
                });
              });
            }
          });
        },
      ),
    );
  }
}
