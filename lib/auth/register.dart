import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookstore_app/auth/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _LoginState();
}

class _LoginState extends State<Register> {
  bool _showPass = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    if (checkField()) {
      try {
        await Auth().createAccountAndSendVerificationEmail(
          email: emailController.text,
          displayName: displayNameController.text,
          password: passwordController.text,
          city: cityController.text,
          number: numberController.text,
          streetAddress: streetController.text,
          postalCode: postalCodeController.text,
        );
        successToast(
          "Verification email has been sent.",
        );
        Future.delayed(Duration(milliseconds: 4), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        String errorMessage = getCustomErrorMessage(e.code);
        errorToast(errorMessage);
      }
    } else {
      errorToast("Unexpected error, Try checking field values again.");
    }
  }

  bool checkField() {
    if (displayNameController.text.isNotEmpty &&
        streetController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        postalCodeController.text.isNotEmpty) {
      if (int.tryParse(numberController.text) == null) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    displayNameController.dispose();
    passwordController.dispose();
    numberController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    streetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBarNormal(
        screenHeight: screenHeight,
        appBarTitle: "Register",
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  emailField(
                    "Email",
                    HugeIcons.strokeRoundedMailAccount01,
                    emailController,
                  ),
                  SizedBox(height: 16),
                  nameField(
                    "Username",
                    HugeIcons.strokeRoundedUserCircle,
                    displayNameController,
                  ),
                  SizedBox(height: 16),
                  nameField(
                    "Number",
                    HugeIcons.strokeRoundedContact02,
                    numberController,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_showPass,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: GoogleFonts.montserrat(
                        color: secondaryColor,
                        fontSize: 14,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(157, 85, 78, 78), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: secondaryColor, width: 2.0),
                      ),
                      prefixIcon: HugeIcon(
                        icon: HugeIcons.strokeRoundedLockPassword,
                        color: Color.fromARGB(157, 85, 78, 78),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPass = !_showPass;
                          });
                        },
                        icon: Icon(
                          _showPass
                              ? HugeIcons.strokeRoundedView
                              : HugeIcons.strokeRoundedViewOff,
                          color: Color.fromARGB(157, 85, 78, 78),
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: streetController,
                    decoration: InputDecoration(
                      labelText: "Street Address",
                      labelStyle: GoogleFonts.montserrat(
                          color: secondaryColor, fontSize: 14),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                            color: Color.fromARGB(157, 85, 78, 78), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: secondaryColor, width: 2.0),
                      ),
                      prefixIcon: HugeIcon(
                        icon: HugeIcons.strokeRoundedHome11,
                        color: Color.fromARGB(157, 85, 78, 78),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Fixing the Row layout issue
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
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
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: secondaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(157, 85, 78, 78),
                                  width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide:
                                  BorderSide(color: secondaryColor, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Adjust space between fields
                      Expanded(
                        child: TextFormField(
                          controller: postalCodeController,
                          decoration: InputDecoration(
                            labelText: "Postal Code",
                            labelStyle: GoogleFonts.montserrat(
                                color: secondaryColor, fontSize: 14),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: secondaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(157, 85, 78, 78),
                                  width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide:
                                  BorderSide(color: secondaryColor, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),

            // Register Button
            TextButton(
              onPressed: () {
                createUserWithEmailAndPassword();
              },
              style: TextButton.styleFrom(
                fixedSize: Size(screenWidth * 0.9, screenHeight * 0.04),
                backgroundColor: primaryColor,
              ),
              child: Text(
                "Register",
                style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style:
                      GoogleFonts.lato(color: Color.fromARGB(157, 85, 78, 78)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.montserrat(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
