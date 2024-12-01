import 'package:bookstore_app/firebase_options.dart';
import 'package:bookstore_app/screens/details.dart';
import 'package:bookstore_app/screens/editProfile.dart';
import 'package:bookstore_app/screens/profile.dart';
import 'package:bookstore_app/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bookstore App",
        home: WidgetTree(),
      ),
    );
  }
}
