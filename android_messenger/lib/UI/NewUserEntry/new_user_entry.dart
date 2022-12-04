import 'dart:io';

import 'package:android_messenger/MainScreens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../auth/authentication.dart';
import '../auth ui/common_auth_methods.dart';
import '../config/colors_collection.dart';



import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:uuid/uuid.dart';





class TakePrimaryUserData extends StatefulWidget {
  const TakePrimaryUserData({Key? key, this.user_email}) : super(key: key);

  final user_email;
  @override
  _TakePrimaryUserDataState createState() => _TakePrimaryUserDataState();
}

class _TakePrimaryUserDataState extends State<TakePrimaryUserData> {
  bool _isLoading = false;

  final GlobalKey<FormState> _takeUserPrimaryInformationKey =
  GlobalKey<FormState>();

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userAbout = TextEditingController();

  late String user_email = widget.user_email;






  String imageUrl = "https://firebasestorage.googleapis.com/v0/b/academia-39c5c.appspot.com/o/test%2Fteacher.jpg?alt=media&token=aaed908f-3370-497c-8b43-2cb92d32eece";
  File? image;
  var path;
  var file;

  var temp = Uuid().v1();


  final picker = ImagePicker();

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();

    final imagePicker = ImagePicker();
    String imageFile;

    var uuid = Uuid();
    var image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('users/').child(temp)
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }




  }








  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile!.path);
    });


  }











  File? pickedimage=null;






  // final CloudStoreDataManagement _cloudStoreDataManagement =
  //     CloudStoreDataManagement();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(34, 48, 60, 1),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: this._takeUserPrimaryInformationKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  _upperHeading(),
                  profilepic(),
                  commonTextFormField(
                      bottomPadding: 30.0,
                      hintText: 'User Name',
                      validator: (inputUserName) {

                        final RegExp _messageRegex = RegExp(r'[a-zA-Z0-9]');

                        if (inputUserName!.length < 6)
                          return "User Name At Least 6 Characters";
                        else if (inputUserName.contains(' ') ||
                            inputUserName.contains('@'))
                          return "Space and '@' Not Allowed...User '_' instead of space";
                        else if (inputUserName.contains('__'))
                          return "'__' Not Allowed...User '_' instead of '__'";
                        else if (!_messageRegex.hasMatch(inputUserName))
                          return "Sorry,Only Emoji Not Supported";
                        return null;
                      },
                      textEditingController: this._userName),
                  commonTextFormField(
                      hintText: 'User About',
                      validator: (inputVal) {
                        if (inputVal!.length < 6)
                          return 'User About must have 6 characters';
                        return null;
                      },
                      textEditingController: this._userAbout),
                  _saveUserPrimaryInformation(),
                ],
              ),
            ),
          ),

        ));
  }

  Widget _upperHeading() {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 50.0),
      child: Center(
        child: Text(
          'Set Up Your Account',
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
      ),
    );
  }

  Widget profilepic(){
    return Center(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(55))
              ),

              child:
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                child: ClipOval(
                    child: Container(
                      height: 80,
                      width: 80,
                      child: (imageUrl != null)
                          ? Image.network(imageUrl)
                          : null,

                    )
                ),

              ),

            ),

          ),

          Positioned(
              top: 120,
              left: 120,
              child:
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.blue[400]
                ),
                child: IconButton(
                  icon: Icon(  Icons.camera_alt_rounded,size: 30,color: Colors.white,
                  ),
                  onPressed: () async{
                    uploadImage();
                  },
                ),
              )


          )
        ],
      ),
    );
  }

  Widget _saveUserPrimaryInformation() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: SizedBox(
              height: 50,
              width: 130,

              child:  ElevatedButton(
                style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                ),


                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        color: AppColors.authscreenbackground,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                onPressed: () async {

                  final uid = await AuthenticationHelper().getID();

                  final String? _getToken = await FirebaseMessaging.instance.getToken();

                  String _collectionName = 'users';

                  // final String? _getToken = '000';

                  final String currDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

                  final String currTime = "${DateFormat('hh:mm a').format(DateTime.now())}";

                  print(_userName.text);
                  print('**********');

                  print(_getToken);

                  FirebaseFirestore.instance
                      .collection(_collectionName).doc(user_email).set({
                    "user_name": _userName.text,
                    "about": _userAbout.text,
                    "activity": [],
                    "connection_request": [],
                    "connections": {},
                    "creation_date": currDate,
                    "creation_time": currTime,
                    "phone_number": "",
                    "profile_pic": imageUrl,
                    "tempimg": temp,
                    "token": _getToken.toString(),
                    "total_connections": "",
                    'uid' : uid,
                    'email':user_email
                  });


                  print('************');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));

                },
              ),

            ))




    );
  }
}


















