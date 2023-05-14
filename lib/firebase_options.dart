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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCv221IdDJDWYh1Wi6zOcQyvTJgDuWyv7s',
    appId: '1:414458741705:android:cce0e0e0b760be58535e18',
    messagingSenderId: '414458741705',
    projectId: 'track-app-d9ed7',
    databaseURL: 'https://track-app-d9ed7-default-rtdb.firebaseio.com',
    storageBucket: 'track-app-d9ed7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDa325hJUZm7Akr54nP0qreSWtecgutrwg',
    appId: '1:414458741705:ios:3ce04ccfd8c78e81535e18',
    messagingSenderId: '414458741705',
    projectId: 'track-app-d9ed7',
    databaseURL: 'https://track-app-d9ed7-default-rtdb.firebaseio.com',
    storageBucket: 'track-app-d9ed7.appspot.com',
    androidClientId: '414458741705-djoteh9nk1s5ulkqc0jru1om93id38hm.apps.googleusercontent.com',
    iosClientId: '414458741705-bg0g0hp9a4mg14fkd5n5ocsgenh2qj8t.apps.googleusercontent.com',
    iosBundleId: 'com.example.background',
  );
}