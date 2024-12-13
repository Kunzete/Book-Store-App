import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:bookstore_app/components/etc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

final User? currentUser = FirebaseAuth.instance.currentUser;
final FirebaseFirestore db = FirebaseFirestore.instance;

class _CartState extends State<Cart> {
  bool loading = true;
  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: 'PKR ',
    );
    return formatter.format(amount);
  }

  Future<void> placeOrder(double totalPrice, BuildContext context) async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw Exception("User not logged in");
      }

      // Fetch user data to get the shipping address
      DocumentSnapshot userDoc =
          await db.collection("user").doc(currentUser.uid).get();

      if (!userDoc.exists) {
        throw Exception("User not found");
      }

      // Extract user shipping details
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      Map<String, dynamic> shippingAddress = {
        "fullName": userData["displayName"] ?? "Unknown",
        "phone": userData["number"] ?? "Unknown",
        "streetAddress": userData["streetAddress"] ?? "Unknown",
        "city": userData["city"] ?? "Unknown",
        "postalCode": userData["postalCode"] ?? "Unknown",
      };

      // Fetch cart items
      final QuerySnapshot cartSnapshot = await db
          .collection("user")
          .doc(currentUser.uid)
          .collection("cart")
          .get();

      if (cartSnapshot.docs.isEmpty) {
        throw Exception("Cart is empty. Cannot place an order.");
      }

      // Extract the book data from the cart
      List<Map<String, dynamic>> books = cartSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          "bookId": doc.id,
          "quantity": data["quantity"] ?? 1,
          "price": data["price"],
          "name": data["name"],
        };
      }).toList();

      var uuid = Uuid();
      String randomId = uuid.v4();
      DocumentReference orderRef = db.collection("orders").doc(randomId);

      await orderRef.set({
        "orderId": randomId,
        "userId": currentUser.uid,
        "createdAt": FieldValue.serverTimestamp(),
        "totalPrice": totalPrice,
        "status": "Pending", // Order starts with a "Pending" status
        "shippingAddress": shippingAddress, // Include shipping address
        "books": books,
      });

      // Clear the user's cart
      WriteBatch batch = db.batch();
      for (var doc in cartSnapshot.docs) {
        batch.delete(doc.reference);
      }

      batch.update(db.collection("user").doc(currentUser.uid), {
        "cartCount": 0,
      });

      await batch.commit();
      successToast("Order placed successfully!");
      Navigator.pop(context);
    } catch (e) {
      errorToast("Error placing order: $e");
      // Handle errors, e.g., show a dialog or snackbar to notify the user
    }
  }

  Future<void> removeFromCart(String productId) async {
    DocumentReference userDoc = db.collection("user").doc(currentUser!.uid);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot userSnapshot = await transaction.get(userDoc);

      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      int currentItemCount = userData?['cartCount'] ?? 0;

      transaction.delete(
        userDoc.collection("cart").doc(productId),
      );

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

  double calculateTotalPrice(List<QueryDocumentSnapshot> cartItems) {
    double total = 0.0;
    for (var item in cartItems) {
      double price = double.tryParse(item['price'].toString()) ?? 0.0;
      total += price;
    }
    return total;
  }

  void showCheckoutBottomSheet(double totalPrice) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Checkout",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Total: ${formatCurrency(totalPrice)}",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  await placeOrder(totalPrice, context);
                },
                icon: Icon(
                  Icons.delivery_dining,
                  color: Colors.white,
                ),
                label: Text(
                  "Cash on Delivery",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 48),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
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
            return Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error!"));
          }

          if (snapshot.hasData) {
            final cartItems = snapshot.data!.docs;
            if (cartItems.isEmpty) {
              return Center(child: Text("Your cart is empty."));
            }

            double totalPrice = calculateTotalPrice(cartItems);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item =
                          cartItems[index].data() as Map<String, dynamic>;
                      double price =
                          double.tryParse(item['price'].toString()) ?? 0.0;
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
                          subtitle: Text(formatCurrency(price)),
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
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () => showCheckoutBottomSheet(totalPrice),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48),
                      backgroundColor: primaryColor,
                    ),
                    child: Text(
                      "Proceed to Checkout",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(
            child: Text("Your cart is empty."),
          );
        },
      ),
    );
  }
}
