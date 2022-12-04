import 'dart:io';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';



late String imageup;


class profilescreen extends StatefulWidget {
  const profilescreen({Key? key, this.name, this.about, this.image, this.createdate, this.createtime, this.email, this.tempimg,}) : super(key: key);

  final name;
  final about;
  final image;
  final createdate;
  final createtime;
  final email;
  final tempimg;

  @override
  State<profilescreen> createState() => _profilescreenState();
}


class _profilescreenState extends State<profilescreen> {

  late String name = widget.name;
  late String email = widget.email;
  late String about = widget.about;
  late String createdate = widget.createdate;
  late String createtime = widget.createtime;
  late String tempimg = widget.tempimg;
  late String imageUrl = widget.image;


  late final cont1 = TextEditingController()..text = name;
  late final cont2 = TextEditingController()..text = about;


  final GlobalKey<FormState> _takeUserPrimaryInformationKey =
  GlobalKey<FormState>();

  final _form = GlobalKey<FormState>();
  bool _isValid = false;

  void _saveForm() {
    setState(() {
      _isValid = _form.currentState!.validate();
    });
  }

  File? image;
  var path;
  var file;

  late var temp = widget.tempimg;


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
          imageup = imageUrl;
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





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: this._form,
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [

                    Center(
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal,
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
                                    color: Colors.teal[400]
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
                    ),



                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                      child: TextFormField(
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
                        controller: cont1,

                        style: TextStyle(color: Colors.blue[900]),
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          hintStyle: TextStyle(color: Colors.blue),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: TextFormField(
                        validator: (inputVal) {
                          if (inputVal!.length < 6)
                            return 'User About must have 6 characters';
                          return null;
                        },
                        controller: cont2,
                        style: TextStyle(color: Colors.blue[900]),
                        decoration: InputDecoration(
                          labelText: 'User About',
                          hintStyle: TextStyle(color: Colors.blue),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30,),



                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                      child: Text(
                        'Account Created on: ',style: TextStyle(fontSize: 18,color: Colors.blue[900]),
                      )
                    ),

                    Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              createtime,style: TextStyle(fontSize: 16,color: Colors.blue[500]),
                            ),
                            Text(
                              createdate,style: TextStyle(fontSize: 16,color: Colors.blue[500]),
                            ),
                          ],
                        )
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () async{

          _saveForm();
          if(_isValid==true)
            {
              print('*************');
              print(email);
              print(cont1.text);
              print(cont2.text);
              print(email);

              print(imageup);
              print(tempimg);

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(email).update({
                "user_name": cont1.text,

                'about' : cont2.text,
                'profile_pic': imageup,
                'tempimg' :temp


              });

              print('done');

              Navigator.pop(context);

            }



        },
      child: Icon(FontAwesomeIcons.check,
        size: 40, //Icon Size
        color: Colors.white, //Color Of Icon
      )
      ),


    );
  }
}
