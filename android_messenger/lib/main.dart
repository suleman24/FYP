import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UI/auth ui/login.dart';
import 'UI/auth ui/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MaterialApp(
        title: 'Suzo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        home: login(),
      ),);
}
