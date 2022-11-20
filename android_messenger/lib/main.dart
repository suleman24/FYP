import 'package:flutter/material.dart';

import 'UI/auth ui/login.dart';
import 'UI/auth ui/signup.dart';


void main() {
  runApp(
    MaterialApp(
      title: 'Suzo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: login(),
    ),);

}


