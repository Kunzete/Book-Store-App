// ignore_for_file: file_names, overridden_fields

import 'package:bookstore_app/components/etc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class AppBarNormal extends AppBar {
  final double screenHeight;
  final String appBarTitle;
  final BuildContext context;

  AppBarNormal({
    super.key,
    required this.screenHeight,
    required this.appBarTitle,
    required this.context,
  }) : super(
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          toolbarHeight: screenHeight * 0.12, // 12% of screen height
          title: Text(
            appBarTitle,
            style: GoogleFonts.montserrat(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: screenHeight * 0.025,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context,);
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowLeft02,
              color: secondaryColor,
              size: screenHeight * 0.03,
            ),
          ),
          automaticallyImplyLeading: false,
        );
}
