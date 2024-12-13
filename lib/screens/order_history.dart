import 'package:bookstore_app/components/appBarNormal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _ordersStream;

  @override
  void initState() {
    super.initState();
    // Fetch orders where the userId matches the logged-in user
    _ordersStream = _db
        .collection('orders')
        .where('userId', isEqualTo: _auth.currentUser!.uid)
        .snapshots();
  }

  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: 'PKR ',
    );
    return formatter.format(amount);
  }

  Future<void> cancelOrder(String orderId) async {
    await _db.collection("orders").doc(orderId).update({
      "status": "Cancelled",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNormal(
        screenHeight: MediaQuery.of(context).size.height,
        appBarTitle: "Order History",
        context: context,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching orders'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No orders found."));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var orderData = orders[index].data() as Map<String, dynamic>;
              var status = orderData['status'] ?? 'Unknown';
              double totalPrice = orderData['totalPrice'] ?? 0.0;
              List<dynamic> books = orderData['books'] ??
                  []; // Assuming 'books' is an array of book objects

              // Extract the names of the books
              List bookNames =
                  books.map((book) => book['name'] ?? 'Unknown').toList();

              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 5,
                child: ListTile(
                  title: Text('Order ID: ${orders[index].id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: $status'),
                      Text('Total Price: ${formatCurrency(totalPrice)}'),
                      ...bookNames.map((bookName) => Text(bookName)),
                    ],
                  ),
                  trailing: status == 'Pending'
                      ? IconButton(
                          icon: Icon(Icons.cancel_outlined),
                          onPressed: () {
                            PanaraConfirmDialog.show(
                              context,
                              title: "Cancel Order?",
                              message:
                                  "Are you sure you want to cancel your order?",
                              confirmButtonText: "Confirm",
                              cancelButtonText: "Cancel",
                              onTapCancel: () {
                                Navigator.pop(context);
                              },
                              onTapConfirm: () {
                                cancelOrder(orders[index].id);
                                Navigator.pop(context);
                              },
                              panaraDialogType: PanaraDialogType.error,
                              barrierDismissible: true,
                            );
                          },
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
