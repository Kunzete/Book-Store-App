// ignore_for_file: unused_import

import 'package:bookstore_app/screens/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class GetBooks extends StatelessWidget {
  final String documentId;

  const GetBooks({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.04;
    double verticalPadding = screenHeight * 0.03;

    // Base URL of PHP server
    String baseUrl = 'http://192.168.10.6/Bookstore_admin_dashboard/';

    // Get collection
    CollectionReference books = FirebaseFirestore.instance.collection('books');
    return FutureBuilder<DocumentSnapshot>(
      future: books.doc(documentId).get(),
      builder: ((context, snapshot) {
        // Check the connection state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text(""),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('No book found.'));
        }

        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        String coverImageUrl = Uri.encodeFull('$baseUrl${data['cover_image']}');

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Details(documentId: data['id']),
            ),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: screenHeight * 0.35, // Limit the height of the card
              maxWidth: screenWidth / 2 - 20, // Limit the width of the card
            ),
            width: screenWidth / 2 - 20,
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
                  child: Image.network(
                    coverImageUrl,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: screenHeight * 0.23,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(child: Text('Image not found'));
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'] ?? 'No Title',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data['author'] ?? 'No author',
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
                SizedBox(height: 5),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Book {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get document IDs
  Future<List<String>> getDocIds() async {
    List<String> docIds = []; // Create a local list to store document IDs

    try {
      // Fetch documents from the "books" collection
      QuerySnapshot snapshot = await _db
          .collection("books")
          .orderBy('rating', descending: true)
          .limit(10) // Limit to the top 20 documents
          .get();

      // Extract document IDs
      for (var document in snapshot.docs) {
        docIds.add(document.id); // Use document.id to get the document ID
      }
    } catch (e) {
      print('Error fetching document IDs: $e');
      // Handle the error appropriately (e.g., show a message to the user)
    }

    return docIds; // Return the list of document IDs
  }

  Future<List<String>> getDocIdsRand() async {
    List<String> docIds = []; // Create a local list to store document IDs

    try {
      // Fetch documents from the "books" collection
      QuerySnapshot snapshot =
          await _db.collection("books").orderBy('title').limit(10).get();

      // Extract document IDs
      for (var document in snapshot.docs) {
        docIds.add(document.id); // Use document.id to get the document ID
      }
    } catch (e) {
      print('Error fetching document IDs: $e');
      // Handle the error appropriately (e.g., show a message to the user)
    }

    return docIds; // Return the list of document IDs
  }

  Future<List<String>> getAuthor() async {
    List<String> authors = []; // Create a local list to store author names

    try {
      // Fetch documents from the "authors" collection
      QuerySnapshot snapshot = await _db.collection("authors").get();

      // Extract author name from each document
      for (var document in snapshot.docs) {
        // Assuming the 'author' field exists in the document
        String authorName = document['author'] ??
            'Unknown Author'; // Use a default value if 'author' is not present
        authors.add(authorName); // Add the author name to the list
      }
    } catch (e) {
      print('Error fetching author names: $e');
    }

    return authors; // Return the list of author names
  }
}
