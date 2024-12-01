import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
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
  User? get currentUser => _firebaseAuth.currentUser;

  // Declare controllers at the top
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with current user data
    if (currentUser != null) {
      emailController.text = currentUser?.email ?? '';
      nameController.text = currentUser?.displayName ?? '';
      // You can add logic to populate phone number if available
      numberController.text = currentUser?.phoneNumber ?? '';
    }
  }

  Future<void> updateCredentials({
    required String email,
    required String name,
  }) async {
    await currentUser?.verifyBeforeUpdateEmail(email);
    await currentUser?.updateDisplayName(name);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double circleSize =
        screenHeight < screenWidth ? screenHeight * 0.12 : screenWidth * 0.12;
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
            TextButton(
              onPressed: () {
                updateCredentials(
                  email: emailController.text,
                  name: nameController.text,
                );
                successToast("Updated Credentials Successfully.");
                emailController.clear();
                nameController.clear();
                numberController.clear();
                Future.delayed(
                  Duration(seconds: 4),
                  () => Navigator.pop(context),
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