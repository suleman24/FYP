import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:circle_list/circle_list.dart';
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

                        },
                        onLongPress: () async {

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
                            color: Colors.blue,
                            width: 3,
                          )),
                      child: GestureDetector(
                        onTap: () async {
                          //_extraTextManagement(MediaTypes.Text);
                        },
                        child: Icon(
                          Icons.text_fields_rounded,
                          color: Colors.blue,
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
                          //await _documentSend();
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
                        onTap: () async {

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








