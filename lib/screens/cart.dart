import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

final User? currentUser = FirebaseAuth.instance.currentUser;
final FirebaseFirestore db = FirebaseFirestore.instance;

class _CartState extends State<Cart> {
  bool loading = true; // Move loading state here

  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_US', // Change to your desired locale
      symbol: 'PKR ', // Change to your desired currency symbol
    );
    return formatter.format(amount);
  }

  Future<void> removeFromCart(String productId) async {
    DocumentReference userDoc = db.collection("user").doc(currentUser!.uid);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot userSnapshot = await transaction.get(userDoc);

      // Cast the data to a Map<String, dynamic>
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      // Safely access the itemCount field
      int currentItemCount = userData?['cartCount'] ?? 0;

      // Remove the item from the cart
      transaction.delete(
        userDoc.collection("cart").doc(productId),
      );

      // Decrement the item count
      if (currentItemCount > 0) {
        transaction.update(userDoc, {
          'cartCount': currentItemCount - 1,
        });
      }
    });

    await refreshPage();
  }

  Future<void> refreshPage() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBarNormal(
        screenHeight: screenHeight,
        appBarTitle: "My Cart",
        context: context,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection("user")
            .doc(currentUser!.uid)
            .collection("cart")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error!"));
          }

          // Set loading to false when data is available
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            loading = false; // Disable loading
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Your cart is empty."));
          }

          final cartItems = snapshot.data!.docs;

          return Skeletonizer(
            enabled: loading,
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index].data() as Map<String, dynamic>;
                double price = double.tryParse(item['price'].toString()) ??
                    0.0; // Ensure price is a double
                return Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    title: Text(
                      "${item['name']}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    subtitle:
                        Text(formatCurrency(price)), // Use the formatted price
                    trailing: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        removeFromCart(
                            cartItems[index].id); // Call removeFromCart
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
