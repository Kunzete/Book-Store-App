import 'package:bookstore_app/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hugeicons/hugeicons.dart';

class ShoppingCartIcon extends StatelessWidget {
  final User? user;

  const ShoppingCartIcon({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container(); // Return an empty container if the user is not logged in
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Icon(Icons.error); // Handle error
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Container(); // Return empty if no data
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        int itemCount =
            data['cartCount'] ?? 0; // Get the item count from the document

        return Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedShoppingCart01,
                color: Colors.black,
                size: 24, // Adjust size as needed
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(),
                ),
              ),
            ),
            if (itemCount > 0)
              Positioned(
                top: 3,
                right: 3,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Center(
                    child: Text(
                      itemCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
