
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../MainScreens/main_screen.dart';
import '../UI/auth ui/login.dart';


class Check extends StatefulWidget {
  const Check({super.key, required this.name});

  final name;

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  final _auth=FirebaseAuth.instance;

  late String name = widget.name;


  @override
  Widget build(BuildContext context) {

    if(_auth.currentUser==null){
      return login();
    }
    else{

      final  user =  _auth.currentUser;
      final userid = user?.uid;

      return MainScreen(name:name);
    }
  }
}
