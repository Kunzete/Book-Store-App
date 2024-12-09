import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:uuid/uuid.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.documentId});

  final String documentId;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Future<void> addToCart(String productId, String name, double price) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return; // Exit if the user is not logged in
      }

      final Uuid uuid = Uuid();

      String uniqueId = uuid.v4(); // Generate a unique ID

      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .collection('cart')
          .doc(uniqueId)
          .set(
        {
          'id': productId,
          'name': name,
          'price': price,
        },
      );

      // Update the cart item count in the user's document
      final userDocRef =
          FirebaseFirestore.instance.collection('user').doc(user.uid);
      await userDocRef.update({
        'cartCount': FieldValue.increment(1), // Increment total cart count
      });

      successToast("Item Added To Cart.");
    } catch (e) {
      errorToast('Error adding to cart: $e');
    }
  }

  Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.05;
    double verticalPadding = screenHeight * 0.03;

    return Scaffold(
      appBar: AppBarNormal(
        screenHeight: screenHeight,
        appBarTitle: "Book Detail",
        context: context,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('books')
            .doc(widget.documentId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text(""));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No book found.'));
          }
          data = snapshot.data!.data() as Map<String, dynamic>;

          String baseUrl = 'http://localhost/Bookstore_admin_dashboard/';
          String imageUrl = Uri.encodeFull('$baseUrl${data!['cover_image']}');
          return LayoutBuilder(builder: (context, constraints) {
            return Container(
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
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: verticalPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data!['title'],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            data!['author'],
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
                                  'Price',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  "${data!['price']}PKR",
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
                                  'Lang',
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
                                  'Category',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  data!['category'],
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
                      padding:
                          EdgeInsets.symmetric(vertical: verticalPadding - 10),
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
                            """${data!['description']}""",
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 115, 115, 115),
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
                    Container(
                      height: screenHeight * 0.35,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('books')
                            .where("category", isEqualTo: data!['category'])
                            .limit(5)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                                child: Text('No similar books found.'));
                          }

                          // Now we can safely access the data
                          List<DocumentSnapshot> similarBooks =
                              snapshot.data!.docs;

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: similarBooks.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> bookData =
                                  similarBooks[index].data()
                                      as Map<String, dynamic>;
                              String coverImageUrl = Uri.encodeFull(
                                  '$baseUrl${bookData['cover_image']}');

                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Details(
                                        documentId: similarBooks[index].id),
                                  ),
                                ),
                                child: Container(
                                  width: screenWidth / 2 - 10,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: horizontalPadding - 5),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        child: Image.network(
                                          coverImageUrl,
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: screenHeight * 0.25,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                                child: Text('Image not found'));
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: horizontalPadding,
                                          vertical: verticalPadding - 15,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              bookData['title'] ?? 'No Title',
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                              bookData['author'] ??
                                                  'Unknown Author',
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
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
                          "Hi",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(35),
          ),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              fixedSize: Size(double.infinity, 10),
            ),
            label: Text(
              "Add To Cart",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onPressed: () {
              if (data != null) {
                String name = data!['title'] ?? 'Unknown Book'; // Default value
                double price = double.parse(data!['price'] ?? 0.0);

                addToCart(
                  widget.documentId,
                  name,
                  price,
                );
              } else {
                print('Data is null, cannot add to cart.');
              }
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedShoppingCartAdd01,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
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
