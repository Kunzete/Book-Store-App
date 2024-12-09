// ignore_for_file: file_names, must_be_immutable, prefer_final_fields
import 'dart:convert';
import 'dart:js_interop';

import 'package:bookstore_app/components/bottomAppBar.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/details.dart';
import 'package:bookstore_app/screens/profile.dart';
import 'package:bookstore_app/services/cart_Icon.dart';
import 'package:bookstore_app/services/getAllBooks.dart';
import 'package:bookstore_app/services/getCategorizedBooks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookstore_app/auth/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final User? user = Auth().currentUser;
  bool _isLoading = true;

  Future _reloadPage() async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Homescreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    refreshPage();
  }

  Future<void> refreshPage() async {
    setState(() {
      mounted;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 12), () {
      setState(() {
        _isLoading = false;
      });
    });
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    double circleSize =
        screenHeight < screenWidth ? screenHeight * 0.12 : screenWidth * 0.12;
    double horizontalPadding = screenWidth * 0.04;
    double verticalPadding = screenHeight * 0.03;
    String baseUrl = 'http://localhost/Bookstore_admin_dashboard/';

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
              Skeletonizer(
                enabled: _isLoading,
                child: Skeleton.ignore(
                  child: ShoppingCartIcon(
                    user: user,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: _reloadPage,
        color: primaryColor,
        child: Container(
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
                      label("Category", ""),
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
                      label("Recent Books", ""),
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
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('books')
                              .orderBy('createdAt', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(child: Text('No books found.'));
                            }

                            // Get the list of documents
                            final books = snapshot.data!.docs;
                            return Skeletonizer(
                              enabled: _isLoading,
                              child: ListView.builder(
                                itemCount: books.length,
                                itemBuilder: (context, index) {
                                  // Access the book data
                                  final bookData = books[index].data()
                                      as Map<String, dynamic>;
                                  String coverImageUrl = Uri.encodeFull(
                                      '$baseUrl${books[index]['cover_image']}');
                                  final author =
                                      bookData['author'] ?? 'Unknown Author';
                                  final price = double.parse(
                                      (bookData['price'] ?? 'Unknown Pages'));

                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Details(
                                          documentId: books[index]['id'],
                                        ),
                                      ),
                                    ),
                                    child: bookProgress(
                                      screenWidth,
                                      screenHeight,
                                      coverImageUrl,
                                      author,
                                      price,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      categorizeButtonOne(
                        screenHeight,
                        "Most Popular",
                        "For You",
                      ),
                      Container(
                        height: screenHeight * 0.35,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: FutureBuilder<List<String>>(
                          future: Book().getDocIds(), // Fetch all document IDs
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              ); // Handle error
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Text('No books found.'),
                              ); // Handle empty data
                            }

                            // Now we can safely access the data
                            List<String> docIds = snapshot
                                .data!; // Assuming docIds is a List<String>

                            return Skeletonizer(
                              enabled: _isLoading,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: docIds.length,
                                itemBuilder: (context, index) {
                                  return GetBooks(
                                      documentId: docIds[
                                          index]); // Create GetBooks widget for each document ID
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      categorizeButtonOne(
                          screenHeight, "Best Seller", "Latest"),
                      Container(
                        height: screenHeight * 0.25,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          vertical: 6,
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
    double screenHeight,
    String imageUrl,
    String author,
    double price,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.2,
            height: screenHeight * 0.1,
            child: Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.35, // Responsive width
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Author",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(author),
              ],
            ),
          ),
          SizedBox(
            width: screenWidth * 0.2, // Responsive width
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Price",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text("${price.toString()}PKR"),
              ],
            ),
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GetCategorizedBooks(category: categoryTitle),
          ),
        );
      },
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
