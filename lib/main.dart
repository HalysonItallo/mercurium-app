import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mercurium_app/injection.dart';
import 'firebase_options.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MainBinding mainBinding = MainBinding();
  await mainBinding.dependencies();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}
