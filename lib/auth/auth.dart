import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> createAccountAndSendVerificationEmail({
    required String email,
    required String displayName,
    required String password,
    required String number,
    required String city,
    required String streetAddress,
    required String postalCode,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(displayName);
    await userCredential.user!.sendEmailVerification();

    _db.collection("user").doc(userCredential.user!.uid).set({
      "id": userCredential.user!.uid,
      "email": email,
      "displayName": displayName,
      "role": "user",
      "number": number,
      "city": city,
      "streetAddress": streetAddress,
      "postalCode": postalCode,
      "isVerified": false,
      "cartCount": 0,
    });
    _db.collection("user").doc(userCredential.user!.uid).collection("cart");
  }

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

    if (userCredential.user!.emailVerified == false) {
      errorToast("Email not verified. Please verify your email.");
    } else {
      successToast("Login Successful");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Homescreen(),
        ),
      );
    }
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

  Future<void> deleteAccount() async {
    await _db.collection("user").doc(currentUser!.uid).delete();
    await _firebaseAuth.currentUser?.delete();
  }
}
