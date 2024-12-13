// ignore_for_file: file_names

import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Declare controllers at the top
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController postalController = TextEditingController();

  List<String> docIds = [];
  Future<void> getDocIds() async {
    DocumentSnapshot snapshot =
        await _db.collection('user').doc(currentUser!.uid).get();
    if (snapshot.exists) {
      docIds.add(snapshot.id);
    } else {
      errorToast("Document does not exist");
    }
  }

  Future<void> fetchData() async {
    await getDocIds();
    DocumentSnapshot userDoc =
        await _db.collection("user").doc(docIds[0]).get();

    if (currentUser != null) {
      cityController.text = userDoc['city'] ?? 'N/A';
      streetController.text = userDoc['streetAddress'] ?? 'N/A';
      postalController.text = userDoc['postalCode'] ?? 'N/A';
    }
  }

  Future<void> updateShippingAddress({
    required String city,
    required String street,
    required String postal,
  }) async {
    _db.collection("user").doc(currentUser!.uid).update({
      "city": cityController.text,
      "streetAddress": streetController.text,
      "postalCode": postalController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.04;
    double verticalPadding = screenHeight * 0.03;

    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBarNormal(
        screenHeight: screenHeight,
        appBarTitle: "Shipping Address",
        context: context,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: streetController,
              decoration: InputDecoration(
                labelText: "Street Address",
                labelStyle: GoogleFonts.montserrat(
                  color: secondaryColor,
                  fontSize: 14,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: BorderSide(
                    color: secondaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: BorderSide(
                    color: Color.fromARGB(157, 85, 78, 78),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: BorderSide(
                    color: secondaryColor,
                    width: 2.0,
                  ),
                ),
                prefixIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedAddressBook,
                  color: Color.fromARGB(157, 85, 78, 78),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: "City",
                labelStyle: GoogleFonts.montserrat(
                  color: secondaryColor,
                  fontSize: 14,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: BorderSide(
                    color: secondaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: BorderSide(
                    color: Color.fromARGB(157, 85, 78, 78),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: BorderSide(
                    color: secondaryColor,
                    width: 2.0,
                  ),
                ),
                prefixIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedCity01,
                  color: Color.fromARGB(157, 85, 78, 78),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: postalController,
              decoration: InputDecoration(
                labelText: "Postal Code",
                labelStyle: GoogleFonts.montserrat(
                  color: secondaryColor,
                  fontSize: 14,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: BorderSide(
                    color: secondaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: BorderSide(
                    color: Color.fromARGB(157, 85, 78, 78),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: BorderSide(
                    color: secondaryColor,
                    width: 2.0,
                  ),
                ),
                prefixIcon: HugeIcon(
                  icon: HugeIcons.strokeRoundedCodeCircle,
                  color: Color.fromARGB(157, 85, 78, 78),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextButton(
              onPressed: () {
                updateShippingAddress(
                  city: cityController.text,
                  postal: postalController.text,
                  street: streetController.text,
                );
                successToast("Updated Credentials Successfully.");
                Future.delayed(
                  Duration(seconds: 4),
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homescreen(),
                      ),
                    ),
                  },
                );
              },
              style: TextButton.styleFrom(
                fixedSize: Size(screenWidth * 0.9, screenHeight * 0.04),
                backgroundColor: primaryColor,
              ),
              child: Text(
                "Update",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
