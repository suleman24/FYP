
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../MainScreens/main_screen.dart';
import '../UI/auth ui/login.dart';


class Check extends StatelessWidget {
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    if(_auth.currentUser==null){
      return login();
    }
    else{



      return MainScreen();
    }
  }
}
