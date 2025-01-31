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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCm14JJzjCeS7hbz_d3Zt4ZPo6C9_k748k',
    appId: '1:963023191453:web:00d183cd2ade107ff1c374',
    messagingSenderId: '963023191453',
    projectId: 'fireiskool-f4955',
    authDomain: 'fireiskool-f4955.firebaseapp.com',
    storageBucket: 'fireiskool-f4955.appspot.com',
    measurementId: 'G-S44P13DT61',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAP5lWdbxsrwDC9kzo0-_JTSPD9WKG_CCM',
    appId: '1:963023191453:android:f8c60c016f07324af1c374',
    messagingSenderId: '963023191453',
    projectId: 'fireiskool-f4955',
    storageBucket: 'fireiskool-f4955.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAz758OTTYgINHJYsUJEh-rn4lQKqoioB0',
    appId: '1:963023191453:ios:8bbdd07f46786287f1c374',
    messagingSenderId: '963023191453',
    projectId: 'fireiskool-f4955',
    storageBucket: 'fireiskool-f4955.appspot.com',
    iosBundleId: 'com.example.fluttersample1',
  );
}
