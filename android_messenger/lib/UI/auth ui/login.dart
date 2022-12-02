import 'package:android_messenger/UI/auth%20ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../config/colors_collection.dart';
import '../config/text_style_collection.dart';




class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  late String emaill;
  late String passworddd;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0f1021),

        body: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.signuptextbackground,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),),

                child:Center(
                  child: Text(
                    "Login"
                    ,
                    style: TextStyleCollection.headingTextStyle
                        .copyWith(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              SizedBox(
                height: 80,
              ),

              Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Container(

                  decoration: BoxDecoration(
                    color: AppColors.signuptextbackground,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),


                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Enter Email",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      fillColor: Color(0xff0f1021),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide:
                                          const BorderSide(width: 0.5, color: Colors.white30)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide:
                                          const BorderSide(width: 1, color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      ),
                                      hintText: "i.e abc@gmail.com",
                                      hintStyle: TextStyle(color: Colors.white30)
                                  ),
                                ),



                                SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Enter Password",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                TextFormField(
                                  controller: password,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xff0f1021),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                        const BorderSide(width: 0.5, color: Colors.white30)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                        const BorderSide(width: 1, color: Colors.white)),

                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                                    ),
                                    hintText: "*******",
                                    hintStyle: TextStyle(color: Colors.white30),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
                        child: SizedBox(
                          height: 50,
                          width: 130,
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),


                            ),


                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: AppColors.authscreenbackground,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            onPressed: ()  {

                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )





            ],
          ),
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,

          child: Padding(
            padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signup()));

              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.pureWhiteColor,
                  border: Border.all(
                    color: AppColors.signuptextbackground,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),),

                child:Center(
                  child: Text(
                    "Signup"
                    ,
                    style: TextStyle(color: AppColors.authscreenbackground,fontSize: 18),
                  ),
                ),
              ),
            ),
          ),


        ),
      ),
    );
  }





}
