import 'dart:io';

import 'package:android_messenger/Services/google_maps.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:circle_list/circle_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class GeneralMessagingSection extends StatefulWidget {
  const GeneralMessagingSection({Key? key}) : super(key: key);

  @override
  _GeneralMessagingSectionState createState() => _GeneralMessagingSectionState();
}

class _GeneralMessagingSectionState extends State<GeneralMessagingSection> {








  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Container(
              width:MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  color: Colors.blue,
                shape: BoxShape.circle,//new Color.fromRGBO(255, 0, 0, 0.0),
                ),

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
                        child: Text(
                          "S",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 65.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.pink,
                            width: 3,
                          )),
                      child: GestureDetector(
                        onTap: () async {





                          showDialog(context: context,
                              builder: (context) => AlertDialog(
                                  insetPadding: EdgeInsets.fromLTRB(0,100,0,0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(200),
                                ),
                                actions: [
                            CircleList(
                            initialAngle: 55,
                            outerRadius: MediaQuery.of(context).size.width / 3.05,
                            innerRadius: MediaQuery.of(context).size.width / 5,
                            showInitialAnimation: true,
                            innerCircleColor: Colors.white,
                            outerCircleColor: Colors.pink,
                            origin: Offset(0, 0),
                            rotateMode: RotateMode.allRotate,
                            centerWidget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Click image',style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15
                                  ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                      'or'
                                  ),
                                ),
                                Center(
                                  child: Text(
                                      'Select from Gallery',style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)
                                  ),
                                ),
                              ],
                            ),
                            children: [
                              IconButton(onPressed: (){

                              },
                                  icon: Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                              ),
                              IconButton(onPressed: (){

                              },
                                icon: Icon(
                                  FontAwesomeIcons.image,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),


                            ],
                            ),

                                ],
                              ),
                          );


                            // FilePickerResult? result =
                            // await FilePicker.platform.pickFiles(
                            //   type: FileType.custom,
                            //   allowedExtensions: ['jpg','png','jpeg'],
                            // );
                        },
                        onLongPress: () async {



                        },
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.pink,
                          size: 30.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.purple,
                            width: 3,
                          )),
                      child: GestureDetector(
                        onTap: () async {

                          showDialog(context: context,
                            builder: (context) => AlertDialog(
                              insetPadding: EdgeInsets.fromLTRB(0,100,0,0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              actions: [
                                CircleList(
                                  initialAngle: 55,
                                  outerRadius: MediaQuery.of(context).size.width / 3.05,
                                  innerRadius: MediaQuery.of(context).size.width / 5,
                                  showInitialAnimation: true,
                                  innerCircleColor: Colors.white,
                                  outerCircleColor: Colors.purple,
                                  origin: Offset(0, 0),
                                  rotateMode: RotateMode.allRotate,
                                  centerWidget: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Capture Video',style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15
                                        ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                            'or'
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                            'Select from Gallery',style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15)
                                        ),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    IconButton(onPressed: (){

                                    },
                                      icon: Icon(
                                        Icons.video_camera_back_outlined,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                    ),
                                    IconButton(onPressed: (){

                                    },
                                      icon: Icon(
                                        Icons.video_collection_rounded,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                    ),


                                  ],
                                ),

                              ],
                            ),
                          );
                        },

                        child: Icon(
                          Icons.video_collection,
                          color: Colors.purple,
                          size: 30.0,
                        ),
                      ),
                    ),

                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          )),
                      child: GestureDetector(
                        onTap: () async {
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: [
                              'pdf',
                              'doc',
                              'docx',
                              'ppt',
                              'pptx',
                              'c',
                              'cpp',
                              'py',
                              'text'
                            ],
                          );
                        },
                        child: Icon(
                          Icons.document_scanner_outlined,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.teal,
                            width: 3,
                          )),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>googlemaps()));

                        },
                        child: Icon(
                          Icons.location_on_rounded,
                          color: Colors.teal,
                          size: 30.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.deepOrange,
                            width: 3,
                          )),
                      child: GestureDetector(
                        child: Icon(
                          Icons.music_note_rounded,
                          color: Colors.orange[900],
                          size: 30.0,
                        ),
                        onTap: () async {
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: [
                              'mp3'
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}








