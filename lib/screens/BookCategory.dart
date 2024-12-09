import 'package:bookstore_app/auth/auth.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class Bookcategory extends StatefulWidget {
  const Bookcategory({super.key});

  @override
  State<Bookcategory> createState() => _BookcategoryState();
}

class _BookcategoryState extends State<Bookcategory> {
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.05; // Responsive padding
    double verticalPadding = screenHeight * 0.02; // Responsive padding

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
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowLeft02,
                  color: secondaryColor,
                  size: screenWidth * 0.065, // Responsive icon size
                ),
              ),
              SearchBar(
                leading: HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  size: screenWidth * 0.045, // Responsive icon size
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
                  minWidth: screenWidth * 0.7,
                  maxWidth: screenWidth * 0.7,
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
                    fontSize: screenWidth * 0.04, // Responsive font size
                  ),
                ),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(
                    fontSize: screenWidth * 0.035, // Responsive font size
                  ),
                ),
                trailing: <Widget>[
                  IconButton(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedPreferenceVertical,
                      color: primaryColor,
                      size: screenWidth * 0.05, // Responsive icon size
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: ListView.builder(
          itemCount: 5,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return book_category(
              screenHeight,
              "assets/images/pfp.jpg",
              '"In a hole in the ground lived a hobbit. It was not a nasty hole; it was a hobbit-hole, meaning comfort."',
              '-by J.R.R. Tolkien',
              screenWidth,
            );
          },
        ),
      ),
    );
  }

  Container book_category(double screenHeight, String imageLink,
      String titleText, String titleAuthor, double screenWidth) {
    return Container(
      height: screenHeight * 0.2,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015), // Responsive margin
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
      padding: EdgeInsets.all(screenHeight * 0.015), // Responsive padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: double.infinity,
            width: screenWidth * 0.25, // Responsive width
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imageLink),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            // Use Expanded to take available space
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  left: screenWidth * 0.03), // Responsive padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the start
                children: [
                  Text(
                    titleText,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035, // Responsive font size
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    titleAuthor,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
