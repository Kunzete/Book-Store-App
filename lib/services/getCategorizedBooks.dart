import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:skeletonizer/skeletonizer.dart';

class GetCategorizedBooks extends StatefulWidget {
  final String category;

  const GetCategorizedBooks({super.key, required this.category});

  @override
  _GetCategorizedBooksState createState() => _GetCategorizedBooksState();
}

class _GetCategorizedBooksState extends State<GetCategorizedBooks> {
  late StreamController<QuerySnapshot> _bookStreamController;
  StreamSubscription<QuerySnapshot>? _bookSubscription;

  @override
  void initState() {
    super.initState();
    _bookStreamController = StreamController<QuerySnapshot>();
  }

  void _startListening() {
    _bookSubscription = FirebaseFirestore.instance
        .collection('books')
        .where("category", isEqualTo: widget.category)
        .limit(50) // Limit to 50 documents
        .snapshots()
        .listen((snapshot) {
      if (!_bookStreamController.isClosed) {
        _bookStreamController.add(snapshot);
      }
    });
  }

  void _stopListening() {
    _bookSubscription?.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startListening(); // Start listening when the widget is mounted
  }

  @override
  void dispose() {
    _stopListening(); // Stop listening when the widget is disposed
    _bookStreamController.close(); // Close the stream controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.05;
    double verticalPadding = screenHeight * 0.02;

    // Base URL for image
    String baseUrl = 'http://192.168.10.6/Bookstore_admin_dashboard/';
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
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black54,
                  size: screenWidth * 0.065,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    hintText: "Search books",
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: screenWidth * 0.04,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54,
                      size: screenWidth * 0.05,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: _bookStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.connectionState == ConnectionState.done) {
              setState(() {
                isLoading = true;
              });
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text('Error fetching books. Please try again.'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No books found.'));
            }

            return Skeletonizer(
              enabled: isLoading,
              child: MasonryGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                itemCount: snapshot.data!.docs.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  String coverImageUrl =
                      Uri.encodeFull('$baseUrl${data['cover_image']}');

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Details(documentId: snapshot.data!.docs[index].id),
                      ),
                    ),
                    child: Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.network(
                              coverImageUrl,
                              height: screenHeight * 0.22,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: Text('Image not found'));
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding * 0.5),
                            child: Text(
                              data['title'] ?? 'No Title',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.035,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding * 0.5),
                            child: Text(
                              data['author'] ?? 'Unknown Author',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: screenWidth * 0.03,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
