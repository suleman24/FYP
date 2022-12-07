import 'dart:math';

import 'package:android_messenger/UI/auth%20ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(
      MaterialApp(
        home: login(),
      ));

}

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  bool _isLoading = false;

  final _form = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height*0.95,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Column(
                            children: [
                              SizedBox(
                                height: 60,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 20,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Icon( Icons.wechat_outlined,
                                size: 70,
                                color: Colors.blue[900],

                              ),
                            ],
                          ),


                          SizedBox(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 15,
                                ),

                                Icon(
                                  FontAwesomeIcons.speakap,
                                  color: Colors.blue,
                                  size: 70,
                                )
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              SizedBox(
                                height: 60,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 20,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Icon( Icons.wechat_outlined,
                                size: 70,
                                color: Colors.blue[900],

                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: [

                      Container(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.5,
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).orientation == Orientation.portrait
                                          ? 5.0
                                          : 0.0),
                                  padding: const EdgeInsets.only(top: 18.0, bottom: 30.0),
                                  width: MediaQuery.of(context).size.width*1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue,
                                        blurRadius: 8.0,
                                        spreadRadius: 3.0,
                                        offset: const Offset(0.0, 0.0), // shadow direction: bottom right
                                      )
                                    ],
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0),
                                        bottomLeft:Radius.circular(60.0), bottomRight: Radius.circular(60.0)
                                    ),

                                  ),


                                  child: Form(
                                    key: _form,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                                          child: Container(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 40,
                                                  ),
                                                  TextFormField(
                                                    keyboardType: TextInputType.emailAddress,
                                                    controller: email,
                                                    style: TextStyle(color: Colors.blue[900]),
                                                    decoration: InputDecoration(
                                                      labelText: "Email",
                                                      prefixIcon: Icon(Icons.people),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(15),
                                                          borderSide:
                                                          const BorderSide(width: 0.5, color: Colors.blue)),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(15),
                                                          borderSide:
                                                          const BorderSide(width: 1, color: Colors.blue)),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                                      ),
                                                      hintText: "i.e abc@gmail.com",
                                                      hintStyle: TextStyle(color: Colors.black54),

                                                    ),
                                                    validator: (value) {
                                                      // Check if this field is empty
                                                      if (value == null || value.isEmpty) {
                                                        return 'Email is required';
                                                      }

                                                      // using regular expression
                                                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                                        return "Please enter a valid email address";
                                                      }

                                                      // the email is valid
                                                      return null;
                                                    },
                                                  ),



                                                  SizedBox(
                                                    height: 50,
                                                  ),

                                                  TextFormField(
                                                    controller: password,
                                                    style: TextStyle(color: Colors.blue[900]),
                                                    decoration: InputDecoration(
                                                      labelText: "Password",
                                                      prefixIcon: Icon(Icons.lock),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(15),
                                                          borderSide:
                                                          const BorderSide(width: 0.5, color: Colors.blue)),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(15),
                                                          borderSide:
                                                          const BorderSide(width: 1, color: Colors.blue)),

                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                                      ),
                                                      hintText: "*******",
                                                      hintStyle: TextStyle(color: Colors.black54),
                                                    ),
                                                    validator: (String? password) {
                                                      if (password != null && password.isEmpty) {
                                                        return "Password is Required";
                                                      }
                                                      else if(password!.length<7)
                                                      {
                                                        return "Minimum Password length is 7 ";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ],
                                              )),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 30, 30, 40),
                                          child: SizedBox(
                                            height: 50,
                                            width: 100,
                                            child: Center(
                                                child: IconButton(
                                                  onPressed: (){

                                                  },
                                                  icon: Icon(
                                                    FontAwesomeIcons.circleArrowRight,
                                                    size: 50,
                                                  ),
                                                  color: Colors.blue,
                                                )
                                            ),
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Don`t have an account? '),
                                            GestureDetector(
                                                onTap: (){

                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signup()));

                                                },
                                                child: Text('Sign up', style: TextStyle(color: Colors.blue),))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  left: MediaQuery.of(context).size.width * 0.25,

                                  child:
                                  Container(
                                    height: 70,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                        color: Colors.blue[400]
                                    ),
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('LOGIN',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 25),
                                        ),
                                      ],
                                    ),

                                  )


                              ),

                            ],
                          )

                      ),




                    ],
                  ),


                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        CircleAvatar(
                          backgroundColor: Colors.blue[900],
                          radius: 15,
                        ),

                        CircleAvatar(
                          backgroundColor: Colors.teal[900],
                          radius: 10,
                        ),

                        CircleAvatar(
                          backgroundColor: Colors.blue[900],
                          radius: 15,
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));

  }
}
