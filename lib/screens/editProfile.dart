// ignore_for_file: file_names

import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Declare controllers at the top
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  List<String> docIds = [];
  Future<void> getDocIds() async {
    DocumentSnapshot snapshot =
        await _db.collection('user').doc(currentUser!.uid).get();

    // Check if the document exists
    if (snapshot.exists) {
      // Add the document ID to the list
      docIds.add(snapshot.id);
    } else {
      print("Document does not exist");
    }
  }

  Future<void> fetchData() async {
    await getDocIds();
    DocumentSnapshot userDoc =
        await _db.collection("user").doc(docIds[0]).get();

    if (currentUser != null) {
      emailController.text = currentUser?.email ?? '';
      nameController.text = currentUser?.displayName ?? '';
      numberController.text = userDoc['number']?.toString() ?? '';
    }
  }

  Future<void> updateCredentials({
    required String email,
    required String name,
    required String number,
  }) async {
    await currentUser?.verifyBeforeUpdateEmail(email);
    await currentUser?.updateDisplayName(name);
    _db.collection("user").doc(currentUser!.uid).update({
      "number": numberController.text,
      "email": emailController.text,
      "name": nameController.text
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
        appBarTitle: "Edit Profile",
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
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
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
                  icon: HugeIcons.strokeRoundedMailAccount01,
                  color: Color.fromARGB(157, 85, 78, 78),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Username",
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
                  icon: HugeIcons.strokeRoundedUserCircle,
                  color: Color.fromARGB(157, 85, 78, 78),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: numberController,
              decoration: InputDecoration(
                labelText: "Number",
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
                  icon: HugeIcons.strokeRoundedContact02,
                  color: Color.fromARGB(157, 85, 78, 78),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextButton(
              onPressed: () {
                updateCredentials(
                  email: emailController.text,
                  name: nameController.text,
                  number: numberController.text,
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
