import 'package:bookstore_app/auth/auth.dart';
import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:bookstore_app/screens/cart.dart';
import 'package:bookstore_app/screens/editProfile.dart';
import 'package:bookstore_app/auth/AuthSession.dart';
import 'package:bookstore_app/screens/order_history.dart';
import 'package:bookstore_app/screens/shipping_address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

Future<void> signOut({
  required BuildContext context,
}) async {
  await Auth().signOut();
  successToast("Signed out successfully.");
  Future.delayed(
    Duration(seconds: 4),
    () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WidgetTree(),
      ),
    ),
  );
}

class _ProfileState extends State<Profile> {
  User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;
        double horizontalPadding = screenWidth * 0.05; // 5% of screen width
        double verticalPadding = screenHeight * 0.03; // 3% of screen height
        double profileImageSize = screenWidth * 0.15; // 15% of screen width

        return Scaffold(
          backgroundColor: backgroundLight,
          appBar: AppBarNormal(
            screenHeight: screenHeight,
            appBarTitle: "Profile",
            context: context,
          ),
          body: Container(
            height: screenHeight,
            width: screenWidth,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: profileImageSize,
                      width: profileImageSize,
                      child: ClipOval(
                        child: Image.asset("assets/images/pfp.jpg"),
                      ),
                    ),
                    SizedBox(
                      width: horizontalPadding,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? "Guest",
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: verticalPadding * 0.15,
                          ),
                          Text(
                            user?.email ?? "",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Editprofile(),
                        ),
                      ),
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedSettings01,
                        color: primaryColor,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: verticalPadding * 2,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderHistory(),
                      ),
                    );
                  },
                  child: Container(
                    height: screenHeight * 0.1,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedDeliveryBox02,
                          color: primaryColor,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: horizontalPadding,
                        ),
                        Text(
                          "Order History",
                          style: GoogleFonts.poppins(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: verticalPadding * 0.5,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShippingAddress()),
                  ),
                  child: Container(
                    height: screenHeight * 0.1,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedShippingTruck02,
                          color: primaryColor,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: horizontalPadding,
                        ),
                        Text(
                          "Shipping Address",
                          style: GoogleFonts.poppins(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: verticalPadding * 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cart(),
                      ),
                    );
                  },
                  child: Container(
                    height: screenHeight * 0.1,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedShoppingCart01,
                          color: primaryColor,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: horizontalPadding,
                        ),
                        Text(
                          "Shopping Cart",
                          style: GoogleFonts.poppins(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: verticalPadding * 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    signOut(context: context);
                  },
                  child: Container(
                    height: screenHeight * 0.1,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedLogout02,
                          color: primaryColor,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: horizontalPadding,
                        ),
                        Text(
                          "Log Out",
                          style: GoogleFonts.poppins(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          persistentFooterAlignment: AlignmentDirectional.center,
          persistentFooterButtons: [
            TextButton(
              onPressed: () {
                PanaraConfirmDialog.show(
                  context,
                  title: "Delete account?",
                  message:
                      "Are you sure you want to delete your account? Any data you have saved will be lost.",
                  confirmButtonText: "Confirm",
                  cancelButtonText: "Cancel",
                  onTapCancel: () {
                    Navigator.pop(context);
                  },
                  onTapConfirm: () {
                    Auth().deleteAccount();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WidgetTree(),
                      ),
                    );
                  },
                  panaraDialogType: PanaraDialogType.error,
                  barrierDismissible:
                      false, // optional parameter (default is true)
                );
              },
              child: Text(
                "Delete Account",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
