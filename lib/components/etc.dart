import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:toastification/toastification.dart';

final Color primaryColor = Color(0xFF475144);
final Color secondaryColor = Color.fromARGB(255, 85, 78, 78);
final Color backgroundLight = Color(0xFFF1EEE9);
final Color primaryDark = Color.fromRGBO(64, 86, 99, 1);
final Color secondaryDark = Color.fromARGB(255, 36, 46, 61);

ToastificationItem errorToast(String errorMessage) {
  return toastification.show(
    type: ToastificationType.error,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 3),
    description: Text(
      errorMessage,
      style: GoogleFonts.lato(
        fontSize: 12,
      ),
    ),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    icon: const HugeIcon(
      icon: HugeIcons.strokeRoundedUnavailable,
      color: Colors.red,
      size: 24.0,
    ),
    showIcon: true,
    primaryColor: Colors.green,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: false,
    dragToClose: true,
    applyBlurEffect: false,
  );
}

ToastificationItem successToast(String message) {
  return toastification.show(
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 3),
    description: Text(message),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    icon: const HugeIcon(
      icon: HugeIcons.strokeRoundedTick01,
      color: Colors.green,
      size: 24.0,
    ),
    showIcon: true,
    primaryColor: Colors.green,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: false,
    dragToClose: true,
    applyBlurEffect: false,
  );
}

String getCustomErrorMessage(String errorCode) {
  if (errorCode == 'missing-email') {
    return 'Please enter your email.';
  } else if (errorCode == 'invalid-credential') {
    return 'User not found or Password is incorrect!';
  } else if (errorCode == 'email-already-in-use') {
    return 'Email already in use. Please use a different email.';
  } else if (errorCode == 'weak-password') {
    return 'The password is too weak. Please use a strong password.';
  } else if (errorCode == 'password-does-not-meet-requirements') {
    return 'Please use an Uppercase, Symbol, Number in your password. Password must be between 6-12 characters.';
  } else if (errorCode == 'user-disabled' ||
      errorCode == 'operation-not-allowed') {
    return 'This user has been disabled. Please contact support.';
  } else {
    return 'An unknown error occurred. Please try again.';
  }
}

TextFormField emailField(
  String label,
  dynamic icon,
  TextEditingController controller,
) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
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
        icon: icon,
        color: Color.fromARGB(157, 85, 78, 78),
      ),
    ),
  );
}

TextFormField nameField(
  String label,
  dynamic icon,
  TextEditingController controller,
) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
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
        icon: icon,
        color: Color.fromARGB(157, 85, 78, 78),
      ),
    ),
  );
}
