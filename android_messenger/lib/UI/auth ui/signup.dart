import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../auth/authentication.dart';
import '../../config/colors_collection.dart';
import '../../config/text_style_collection.dart';
import '../NewUserEntry/new_user_entry.dart';
import 'login.dart';


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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0f1021),

      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SingleChildScrollView(
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
                  "Sign Up"
                  ,
                  style: TextStyleCollection.headingTextStyle
                      .copyWith(fontSize: 23, fontWeight: FontWeight.w600),
                ),
              ),
            ),

                SizedBox(
                  height: 40,
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


                  child: Form(
                    key: _form,
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
                                        hintStyle: TextStyle(color: Colors.white30),

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
                          padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
                          child: SizedBox(
                            height: 50,
                            width: 130,
                            child: ElevatedButton(

                              style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                                  backgroundColor: Colors.white
                              ),


                              child: Center(
                                child: Text(
                                  'Signup',
                                  style: TextStyle(
                                      color: AppColors.authscreenbackground,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              onPressed:()async {

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
                      ],
                    ),
                  ),
                ),
                ),



                SizedBox(
                  height: 20,
                ),


                Center(
                  child:Text('Or continue with', style: TextStyle(color: Colors.white,fontSize: 15),)
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 50,
                  child: ClipOval(
                      child: Container(
                        height: 50.0,
                        width: 50.0,
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

        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,

          child: Padding(
            padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));

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
                    "Login"
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




showAlertDialogForSucces(context){
  Widget continueButton = TextButton(
    child: Text("Go to Login"),
    onPressed:  () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const TakePrimaryUserData()));
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