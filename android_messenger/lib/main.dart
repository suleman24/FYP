import 'package:circle_list/circle_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'UI/NewUserEntry/new_user_entry.dart';
import 'UI/auth ui/login.dart';
import 'UI/auth ui/signup.dart';
import 'auth/authentication.dart';
import 'auth/check.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();




  runApp(
      MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}







class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String name='null';

   initState(){

     unamefind();
    super.initState();




  }


  Future<void> unamefind() async {

    final uid = await AuthenticationHelper().getID();
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    name= data.docs[0]['user_name'];


    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Check(name:name)
            )
        )
    );
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Center(
                    child: CircleList(
                      initialAngle: 55,
                      outerRadius: MediaQuery.of(context).size.width / 2.05,
                      innerRadius: MediaQuery.of(context).size.width / 4,
                      showInitialAnimation: true,
                      innerCircleColor: Colors.white,
                      outerCircleColor: Colors.white,
                      origin: Offset(0, 0),
                      rotateMode: RotateMode.allRotate,
                      centerWidget: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 110,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.white,
                            child: Icon(
                              FontAwesomeIcons.speakap,
                              color: Colors.blue,
                              size: 100,
                            )
                          ),
                        ),
                      ),
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 15,
                        ),

                        Icon( Icons.chat,
                        size: 20,
                          color: Colors.blue,
                        ),




                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 15,
                        ),


                        Icon( Icons.chat,
                          size: 20,
                          color: Colors.blue,
                        ),





                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 15,
                        ),



                        Icon( Icons.chat,
                          size: 20,
                          color: Colors.blue,
                        ),


                      ],
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    'Copyright @ Suleman Anwar'
                  ),
                )
              ],
            ),


          ),
        )
    );
  }
}