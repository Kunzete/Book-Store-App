// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, unused_local_variable

import 'dart:async';

import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/login.dart';
import 'package:bookstore_app/screens/register.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final List<String> pictures = [
    "assets/images/Gohan Study.jpeg",
    "assets/images/Books.webp",
    "assets/images/Boy reading.jpg",
    "assets/images/Reading.jpeg",
  ];

  final List<Container> customPageView = [
    Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome To Book Store",
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Finding books can be done through various methods, each offering unique advantages. Public libraries provide extensive collections",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
    Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "AnyWhere, AnyTime",
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Unlock a world of stories at your local library—where every book is a new adventure waiting to be discovered!",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
    Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Quick & Easy",
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Dive into endless possibilities with online bookstores, where your next favorite read is just a click away!",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  ];

  int currentIndex = 0;
  late Timer _timer;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        opacity = 0.0;
      });

      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          currentIndex = (currentIndex + 1) % pictures.length;
          opacity = 1.0;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundLight,
      body: Center(
        child: Column(
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(milliseconds: 500),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(pictures[currentIndex]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(150),
                  ),
                ),
                height: screenHeight * 0.39,
              ),
            ),
            CarouselSlider(
              items: customPageView,
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                pauseAutoPlayOnManualNavigate: true,
                enlargeCenterPage: true,
                height: screenHeight * 0.35,
                autoPlayAnimationDuration: Duration(seconds: 1),
              ),
            ),
            Container(
              height: screenHeight * 0.22,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: Text(
                      "Create New Account",
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor, // Background color
                      fixedSize: Size(screenWidth * 0.9,
                          50), // Set the width to 90% of screenWidth and height to 50
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), // Rounded corners
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.lato(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent, // Background color
                      fixedSize: Size(
                        screenWidth * 0.9,
                        50,
                      ), // Set the width to 90% of screenWidth and height to 50
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: primaryColor),
                        borderRadius:
                            BorderRadius.circular(25), // Rounded corners
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
