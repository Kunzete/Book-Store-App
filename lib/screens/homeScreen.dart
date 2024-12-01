// ignore_for_file: file_names, must_be_immutable, prefer_final_fields
import 'package:bookstore_app/components/bottomAppBar.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/details.dart';
import 'package:bookstore_app/screens/profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookstore_app/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    List<Container> mostPopular = [
      Container(
        height: screenHeight * 0.25,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(18, 0, 0, 0),
              blurRadius: 8,
              spreadRadius: 3,
              offset: Offset(0, 0),
            )
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: double.infinity,
              width: screenWidth * 0.30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/pfp.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.3,
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '"In a hole in the ground lived a hobbit. It was not a nasty hole; it was a hobbit-hole, meaning comfort."',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.025, // Responsive font size
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    '-by J.R.R. Tolkien',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.025, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];

    double circleSize =
        screenHeight < screenWidth ? screenHeight * 0.12 : screenWidth * 0.12;
    double horizontalPadding = screenWidth * 0.04;
    double verticalPadding = screenHeight * 0.03;
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: screenHeight * 0.12,
        leadingWidth: screenWidth,
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ),
                      );
                    },
                    child: Container(
                      height: circleSize,
                      width: circleSize,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/pfp.jpg"),
                          fit: BoxFit.contain,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Hi, ${user?.displayName}",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: (screenWidth + screenHeight) / 65,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                ),
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedShoppingCart01,
                  color: Colors.black,
                  size: (screenWidth + screenHeight) / 45,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchBar(
                leading: HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  size: 18,
                  color: secondaryColor,
                ),
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                shadowColor: WidgetStatePropertyAll(Colors.transparent),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: Color.fromARGB(185, 92, 85, 85),
                    width: 0.63,
                  ),
                ),
                constraints: BoxConstraints(
                  minHeight: screenHeight * 0.06,
                  maxHeight: screenHeight * 0.06,
                ),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 0,
                  ),
                ),
                elevation: WidgetStatePropertyAll(0),
                hintText: "Search",
                hintStyle: WidgetStatePropertyAll(
                  TextStyle(
                    color: Color.fromARGB(185, 92, 85, 85),
                    fontSize: 15,
                  ),
                ),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(
                    fontSize: 14,
                  ),
                ),
                trailing: <Widget>[
                  IconButton(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedPreferenceVertical,
                      color: primaryColor,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 2,
                ),
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    label("Category", "See All >"),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.bottomCenter,
                      width: screenWidth,
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 2,
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        children: [
                          categoryButton(
                            "Education",
                            screenWidth,
                          ),
                          categoryButton(
                            "Fantasy",
                            screenWidth,
                          ),
                          categoryButton(
                            "Novels",
                            screenWidth,
                          ),
                          categoryButton(
                            "Fiction",
                            screenWidth,
                          ),
                          categoryButton(
                            "Adventure",
                            screenWidth,
                          ),
                          categoryButton(
                            "Romance",
                            screenWidth,
                          ),
                        ],
                      ),
                    ),
                    label("Recent Books", "See All >"),
                    Container(
                      width: double.infinity,
                      height: screenHeight * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(18, 0, 0, 0),
                            blurRadius: 8,
                            spreadRadius: 3,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: horizontalPadding,
                      ),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return bookProgress(
                            screenWidth,
                            "Hamlet",
                            "16 H 42 M",
                            "H",
                          );
                        },
                        itemCount: 5,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                    categorizeButtonOne(
                      screenHeight,
                      "Most Popular",
                      "For You",
                    ),
                    Container(
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(),
                          ),
                        ),
                        child: CarouselSlider(
                          items: mostPopular,
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            padEnds: false,
                          ),
                        ),
                      ),
                    ),
                    categorizeButtonOne(screenHeight, "Best Seller", "Latest"),
                    Container(
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(),
                          ),
                        ),
                        child: CarouselSlider(
                          items: mostPopular,
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            padEnds: false,
                          ),
                        ),
                      ),
                    ),
                    label("Explore Authors", "See All >"),
                    SizedBox(
                      height: screenHeight * 0.2,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Authors(
                            screenHeight,
                            screenWidth,
                            "assets/images/pfp.jpg",
                            "Kenny",
                          );
                        },
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomAppBar(),
    );
  }

  Container Authors(
    double screenHeight,
    double screenWidth,
    String imageUrl,
    String authorName,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: screenHeight * 0.15,
            width: screenWidth * 0.15,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryColor,
                width: 1,
              ),
            ),
          ),
          Text(authorName),
        ],
      ),
    );
  }

  Container categorizeButtonOne(
      double screenHeight, String buttonOne, String buttonTwo) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: screenHeight * 0.10,
      child: Wrap(
        spacing: 6,
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
            ),
            child: Text(
              buttonOne,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              side: BorderSide(
                color: primaryColor,
                width: 1,
              ),
            ),
            child: Text(
              buttonTwo,
              style: GoogleFonts.poppins(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container bookProgress(
    double screenWidth,
    String bookName,
    String remainingTime,
    String progress,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.3, // Responsive width
            child: Text(
              bookName,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.3, // Responsive width
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Remaining",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(remainingTime),
              ],
            ),
          ),
          SizedBox(
            width: screenWidth * 0.1, // Responsive width
            child: Text(progress),
          ),
        ],
      ),
    );
  }

  Row label(String labelOne, String labelTwo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          labelOne,
          style: GoogleFonts.poppins(
            color: primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            labelTwo,
            style: GoogleFonts.poppins(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  TextButton categoryButton(String categoryTitle, double screenWidth) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        elevation: 0,
        fixedSize: Size.fromHeight(1),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        side: BorderSide(
          color: primaryColor,
        ),
      ),
      child: Text(
        categoryTitle,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 11,
        ),
      ),
    );
  }
}
