import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../auth/authentication.dart';
import '../NewUserEntry/new_user_entry.dart';
import '../config/colors_collection.dart';
import '../config/text_style_collection.dart';
import 'login.dart';




late String user_email;



class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  bool _isLoading = false;

  final _form = GlobalKey<FormState>();
  bool _isValid = false;

  void _saveForm() {
    setState(() {
      _isValid = _form.currentState!.validate();
    });
  }


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
                                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                          child: Container(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 30,
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
                                                    height: 20,
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
                                          padding: const EdgeInsets.fromLTRB(20, 30, 30, 15),
                                          child: SizedBox(
                                            height: 50,
                                            width: 120,
                                            child: Center(
                                                child: ElevatedButton(

                                                  style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius.circular(30.0),
                                                  ),
                                                  ),


                                                  child: Center(
                                                    child: Text(
                                                      'Signup',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  onPressed:()async {

                                                    user_email = email.text;

                                                    _isLoading = true;

                                                    _saveForm();

                                                    if(_isValid==true)
                                                    {
                                                      AuthenticationHelper()
                                                          .signUp(email.text, password.text)
                                                          .then((result) {
                                                        if (result == null) {
                                                          print("OK");
                                                          showAlertDialogForSucces(context);
                                                        } else {
                                                          print("NO");
                                                          showAlertDialogForError(context);
                                                        }
                                                      });



                                                    }
                                                    _isLoading = false;

                                                  },
                                                ),
                                            ),
                                          ),
                                        ),




                                        Container(
                                          width: 300,
                                          child: ElevatedButton(onPressed: (){},
                                            style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(30.0),
                                            ),
                                              backgroundColor: Colors.white,
                                              elevation: 5,
                                              shadowColor: Colors.blue[900],

                                            ),

                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Or continue with', style: TextStyle(color: Colors.blue[900],fontSize: 15),),
                                                CircleAvatar(
                                                  backgroundColor: Colors.transparent,
                                                  radius: 20,
                                                  child: ClipOval(
                                                      child: Container(
                                                        height: 20.0,
                                                        width: 20.0,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/google.png'),
                                                            fit: BoxFit.fill,
                                                          ),
                                                          shape: BoxShape.circle,
                                                        ),
                                                      )
                                                  ),

                                                ),
                                              ],
                                            ),


                                          ),
                                        ),

                                        SizedBox(
                                          height: 30,
                                        ),



                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Already have an account? '),
                                            GestureDetector(
                                                onTap: (){

                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));

                                                },
                                                child: Text('Login', style: TextStyle(color: Colors.blue),))
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
                                        Text('Sign up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 25),
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







showAlertDialogForSucces(context){
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => TakePrimaryUserData(user_email: user_email,)));
    },
  );

  AlertDialog alert = AlertDialog(
    content: Text("Account has been created successfully"),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}




showAlertDialogForError(BuildContext context) {

  Widget continueButton = TextButton(
    child: Text("OK"),
    onPressed:  () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const signup()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("This Account cannot be created"),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}