import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // This is the file you just generated

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // This connects your Flutter app to 'just-smile-calling-service'
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(MyApp());
}