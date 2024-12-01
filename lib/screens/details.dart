import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'dart:math';
import 'package:bookstore_app/components/etc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double screenHeight = constraints.maxHeight;
      double screenWidth = constraints.maxWidth;
      double horizontalPadding = screenWidth * 0.05;
      double verticalPadding = screenHeight * 0.03;
      int minWords = 10;
      int maxWords = 50;

      // Generate a random number of words between minWords and maxWords
      int randomWordCount =
          Random().nextInt(maxWords - minWords + 1) + minWords;

      // Generate the Lorem Ipsum text with the random word count
      String loremText = loremIpsum(words: randomWordCount);

      return Scaffold(
        appBar: AppBarNormal(
          screenHeight: screenHeight,
          appBarTitle: "Book Detail",
          context: context,
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.4,
                  color: Colors.red,
                  child: Image.asset(
                    "assets/images/pfp.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: verticalPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Toji Book",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Kunzete",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: verticalPadding - 10,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: verticalPadding - 5,
                    horizontal: horizontalPadding,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        spreadRadius: 2,
                        blurRadius: 15,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rating',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  '4.5',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                  ),
                                ),
                                SizedBox(width: 4.0),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: .4,
                          width: .2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pages',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '500',
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: .4,
                          width: .2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Language',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'En',
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: .4,
                          width: .2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Author',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Kunzete',
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: verticalPadding - 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: verticalPadding - 10,
                      ),
                      Text(
                        """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas feugiat in odio id lacinia. In tincidunt est at suscipit sagittis. Nullam fermentum nunc ac vehicula tristique. Proin pharetra massa libero, eu scelerisque est posuere eget. Cras auctor ut nibh id eleifend. Integer in lorem ultrices, eleifend risus non, consectetur leo.""",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                label("Similiar Books", "See All >"),
                SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      5,
                      (index) => bookCards(
                        screenWidth,
                        horizontalPadding,
                        verticalPadding,
                        "Toji Book ${index + 1}", // Example title
                        "Kunzete", // Author name
                        "assets/images/pfp.jpg", // Image path
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                label("Reviews", "See All >"),
                Column(
                  children: List.generate(
                    2,
                    (index) => reviewCard(
                      verticalPadding,
                      horizontalPadding,
                      "Kunzete ${index + 1}",
                      "assets/images/pfp.jpg",
                      loremText,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Container reviewCard(
    double verticalPadding,
    double horizontalPadding,
    String userName,
    String imageUrl,
    String reviewText,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding - 10,
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding - 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            spreadRadius: 2,
            blurRadius: 30,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
              child: ClipOval(
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              userName,
              style: GoogleFonts.poppins(),
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 14,
                ),
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 14,
                ),
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 14,
                ),
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 14,
                ),
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 14,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: verticalPadding - 10,
              horizontal: horizontalPadding,
            ),
            child: Text(
              reviewText,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container bookCards(
      double screenWidth,
      double horizontalPadding,
      double verticalPadding,
      String bookTitle,
      String authorName,
      String imageUrl) {
    return Container(
      width: screenWidth / 2 - 10,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding - 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding - 15,
            ),
            child: Column(
              children: [
                Text(
                  bookTitle,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Column(
              children: [
                Text(
                  authorName,
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
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
