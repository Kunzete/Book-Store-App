// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDRv1I2892AVfz8uJ48o80JsDCI8dsOV4M',
    appId: '1:131283858195:web:2873c1863d9599cdbba0e6',
    messagingSenderId: '131283858195',
    projectId: 'bookstore-3bdc6',
    authDomain: 'bookstore-3bdc6.firebaseapp.com',
    storageBucket: 'bookstore-3bdc6.firebasestorage.app',
    measurementId: 'G-ER1HS8RCV7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPE8BOHGp_OzrOva9Q8Q6phgZCpQYXrDk',
    appId: '1:131283858195:android:a6019d25ccb54cf5bba0e6',
    messagingSenderId: '131283858195',
    projectId: 'bookstore-3bdc6',
    storageBucket: 'bookstore-3bdc6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8hhKsajFCcMp78tQEXaDu4ndyTyd0jzU',
    appId: '1:131283858195:ios:9b003e3ecfece7c3bba0e6',
    messagingSenderId: '131283858195',
    projectId: 'bookstore-3bdc6',
    storageBucket: 'bookstore-3bdc6.firebasestorage.app',
    iosBundleId: 'com.example.bookstoreApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA8hhKsajFCcMp78tQEXaDu4ndyTyd0jzU',
    appId: '1:131283858195:ios:9b003e3ecfece7c3bba0e6',
    messagingSenderId: '131283858195',
    projectId: 'bookstore-3bdc6',
    storageBucket: 'bookstore-3bdc6.firebasestorage.app',
    iosBundleId: 'com.example.bookstoreApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDRv1I2892AVfz8uJ48o80JsDCI8dsOV4M',
    appId: '1:131283858195:web:09b27942c50e32cabba0e6',
    messagingSenderId: '131283858195',
    projectId: 'bookstore-3bdc6',
    authDomain: 'bookstore-3bdc6.firebaseapp.com',
    storageBucket: 'bookstore-3bdc6.firebasestorage.app',
    measurementId: 'G-Z3TR1N6HSH',
  );
}
