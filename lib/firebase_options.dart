// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAxpEQ4Cd-SjJfYFmbHoipHEyuXwiX39lo',
    appId: '1:783349326005:web:795332acbb61f918fedefc',
    messagingSenderId: '783349326005',
    projectId: 'mincamacae',
    authDomain: 'mincamacae.firebaseapp.com',
    databaseURL: 'https://mincamacae-default-rtdb.firebaseio.com',
    storageBucket: 'mincamacae.appspot.com',
    measurementId: 'G-2B2XYDB1R1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDht16TF4SdVQT4fiw3zo51St827zT3kqk',
    appId: '1:783349326005:android:255249343f939335fedefc',
    messagingSenderId: '783349326005',
    projectId: 'mincamacae',
    databaseURL: 'https://mincamacae-default-rtdb.firebaseio.com',
    storageBucket: 'mincamacae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtjoiI7Y02ufbgO1Pb3zs8xJ9mrWMJ6zk',
    appId: '1:783349326005:ios:bb495bb53c8a7c2bfedefc',
    messagingSenderId: '783349326005',
    projectId: 'mincamacae',
    databaseURL: 'https://mincamacae-default-rtdb.firebaseio.com',
    storageBucket: 'mincamacae.appspot.com',
    iosBundleId: 'com.example.mincMacae',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtjoiI7Y02ufbgO1Pb3zs8xJ9mrWMJ6zk',
    appId: '1:783349326005:ios:2947787452d547fefedefc',
    messagingSenderId: '783349326005',
    projectId: 'mincamacae',
    databaseURL: 'https://mincamacae-default-rtdb.firebaseio.com',
    storageBucket: 'mincamacae.appspot.com',
    iosBundleId: 'com.example.mincMacae.RunnerTests',
  );
}
