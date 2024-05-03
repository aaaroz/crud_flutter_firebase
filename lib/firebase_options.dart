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
    apiKey: 'AIzaSyBHt2guSa8496l8Nm_Ex1V2HD-gxLiCdhc',
    appId: '1:1086540169760:web:4f3c8fe421deca6e7a3245',
    messagingSenderId: '1086540169760',
    projectId: 'flutter-fb-6ac88',
    authDomain: 'flutter-fb-6ac88.firebaseapp.com',
    storageBucket: 'flutter-fb-6ac88.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUWueQ4k4Am4Njumk2JNt6n5L_G2_lYBY',
    appId: '1:1086540169760:android:a74dcc3bc23ddb777a3245',
    messagingSenderId: '1086540169760',
    projectId: 'flutter-fb-6ac88',
    storageBucket: 'flutter-fb-6ac88.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzz6bohTgeMEAcA0HZlCiTDzUkyOv40rg',
    appId: '1:1086540169760:ios:ca70510226d554537a3245',
    messagingSenderId: '1086540169760',
    projectId: 'flutter-fb-6ac88',
    storageBucket: 'flutter-fb-6ac88.appspot.com',
    iosBundleId: 'com.example.flutterFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzz6bohTgeMEAcA0HZlCiTDzUkyOv40rg',
    appId: '1:1086540169760:ios:ca70510226d554537a3245',
    messagingSenderId: '1086540169760',
    projectId: 'flutter-fb-6ac88',
    storageBucket: 'flutter-fb-6ac88.appspot.com',
    iosBundleId: 'com.example.flutterFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBHt2guSa8496l8Nm_Ex1V2HD-gxLiCdhc',
    appId: '1:1086540169760:web:343f9aae1e2d61107a3245',
    messagingSenderId: '1086540169760',
    projectId: 'flutter-fb-6ac88',
    authDomain: 'flutter-fb-6ac88.firebaseapp.com',
    storageBucket: 'flutter-fb-6ac88.appspot.com',
  );
}