// ignore_for_file: annotate_overrides, overridden_fields

import 'package:bookstore_app/auth/auth.dart';
import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/auth/AuthSession.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();

  Future<void> sendPasswordResetEmail() async {
    try {
      await Auth().sendPasswordResetEmail(
        email: emailController.text,
      );
      successToast("Password reset email has been sent.");
      Future.delayed(Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WidgetTree(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage = getCustomErrorMessage(e.code);
      errorToast(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBarNormal(
        screenHeight: screenHeight,
        appBarTitle: "Reset Password",
        context: context,
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.2,
            // color: Colors.black,
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                emailField(
                  "Email",
                  HugeIcons.strokeRoundedMailAccount01,
                  emailController,
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              sendPasswordResetEmail();
            },
            style: TextButton.styleFrom(
              fixedSize: Size(screenWidth * 0.9, screenHeight * 0.04),
              backgroundColor: primaryColor,
            ),
            child: Text(
              "Reset Password",
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
