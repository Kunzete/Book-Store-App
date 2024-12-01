import 'package:bookstore_app/auth.dart';
import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/register.dart';
import 'package:bookstore_app/screens/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _rememberMe = false;
  bool _showPass = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        context: context,
        email: emailController.text,
        password: passwordController.text,
      );
      emailController.clear();
      passwordController.clear();
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
        appBarTitle: "Login",
        context: context,
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.35,
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
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            activeColor: primaryColor,
                            splashRadius: 0.2,
                            value: _rememberMe,
                            side: BorderSide(
                              color: primaryColor,
                              width: 1.5,
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Remember Me',
                            style: GoogleFonts.roboto(
                              color: secondaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPassword(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.montserrat(
                            color: secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              signInWithEmailAndPassword();
            },
            style: TextButton.styleFrom(
              fixedSize: Size(screenWidth * 0.9, screenHeight * 0.04),
              backgroundColor: primaryColor,
            ),
            child: Text(
              "Login",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.lato(
                        color: Color.fromARGB(157, 85, 78, 78),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
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
