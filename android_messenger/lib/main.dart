import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UI/NewUserEntry/new_user_entry.dart';
import 'UI/auth ui/login.dart';
import 'UI/auth ui/signup.dart';
import 'auth/check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MaterialApp(debugShowCheckedModeBanner: false, home: Check()));
}
