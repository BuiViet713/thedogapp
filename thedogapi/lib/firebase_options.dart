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
    apiKey: 'AIzaSyDMItn8PtgI7j4iUIp-fg44D4AL9_qfB5M',
    appId: '1:164785343131:web:11fb3d0941a1836b3fd43e',
    messagingSenderId: '164785343131',
    projectId: 'thedogapp-a4d12',
    authDomain: 'thedogapp-a4d12.firebaseapp.com',
    storageBucket: 'thedogapp-a4d12.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzXzMfsTUWfzIyCzdap2KcoXQz8ggjZyk',
    appId: '1:164785343131:android:a59e1b175db4def93fd43e',
    messagingSenderId: '164785343131',
    projectId: 'thedogapp-a4d12',
    storageBucket: 'thedogapp-a4d12.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALCXx3qgHDTqMLZRv_XQs1DZ96ZQ5E7c4',
    appId: '1:164785343131:ios:54a1b9263afaa0b33fd43e',
    messagingSenderId: '164785343131',
    projectId: 'thedogapp-a4d12',
    storageBucket: 'thedogapp-a4d12.appspot.com',
    iosClientId: '164785343131-nqpdhqbj663m6fjie8a8np7msbve4r5r.apps.googleusercontent.com',
    iosBundleId: 'com.example.thedogapi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyALCXx3qgHDTqMLZRv_XQs1DZ96ZQ5E7c4',
    appId: '1:164785343131:ios:50f2bc0a104e56943fd43e',
    messagingSenderId: '164785343131',
    projectId: 'thedogapp-a4d12',
    storageBucket: 'thedogapp-a4d12.appspot.com',
    iosClientId: '164785343131-gio9jauabqtrh3ph3jgusbkknb5rndf8.apps.googleusercontent.com',
    iosBundleId: 'com.example.thedogapi.RunnerTests',
  );
}
