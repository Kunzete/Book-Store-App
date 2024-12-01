import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookstore_app/auth.dart';

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

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createAccountAndSendVerificationEmail(
        email: emailController.text,
        displayName: displayNameController.text,
        password: passwordController.text,
      );
      successToast(
        "Verification email has been sent to ${emailController.text}",
      );
      Future.delayed(Duration(milliseconds: 4), () {
        emailController.clear();
        displayNameController.clear();
        passwordController.clear();
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
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.33,
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
                ),
                SizedBox(
                  height: 16.0,
                ),
                nameField(
                  "Username",
                  HugeIcons.strokeRoundedUserCircle,
                  displayNameController,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: !_showPass,
                  decoration: InputDecoration(
                    labelText: "Password",
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
                            ? HugeIcons.strokeRoundedView // Show icon
                            : HugeIcons.strokeRoundedViewOff, // Hide icon
                        color: Color.fromARGB(157, 85, 78, 78),
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.2,
            child: Column(
              children: [
                // IMPLEMENT SOCIAL MEDIA LOGIN/REGISTER!!!
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.lato(
                        color: Color.fromARGB(157, 85, 78, 78),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.montserrat(
                          color: secondaryColor, // Change color to your liking
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
        ],
      ),
    );
  }
}
