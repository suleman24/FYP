import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../auth ui/common_auth_methods.dart';
import '../config/colors_collection.dart';

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
            "profile_pic": "",
            "token": _getToken.toString(),
            "total_connections": "",
          });


          print('************');


        },
      ),

    ))




    );
  }
}


















