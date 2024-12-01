import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user?.emailVerified == true) {
      successToast("Login Successful");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Homescreen(),
        ),
      );
    } else {
      errorToast("Email not verified. Please verify your email.");
      await _firebaseAuth.signOut();
    }
  }

  Future<void> createAccountAndSendVerificationEmail({
    required String email,
    required String displayName,
    required String password,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.updateDisplayName(displayName);
    await userCredential.user?.sendEmailVerification();
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(
      email: email,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
