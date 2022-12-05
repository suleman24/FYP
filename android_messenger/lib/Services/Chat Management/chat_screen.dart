
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:animations/animations.dart';
import 'package:circle_list/circle_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';



class chatscreen extends StatefulWidget {
  final String userName;
  final String about;
  final String image;

  chatscreen({Key? key, required this.userName, required this.about, required this.image}) : super(key: key);

  @override
  _chatscreenState createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  bool _isLoading = false;
  bool _writeTextPresent = false;
  bool _showEmojiPicker = false;

  late String name = widget.userName;
  late String about = widget.about;
  late String image = widget.image;


  final TextEditingController _typedText = TextEditingController();

  late bool isShowSticker;

  @override
  void initState() {
    super.initState();
    isShowSticker = false;
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);

  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: WillPopScope(
          onWillPop: () async {
            if (this._showEmojiPicker) {
              if (mounted) {
                setState(() {
                  this._showEmojiPicker = false;
                });
              }
              return false;
            }
            return true;
          },


        child: Scaffold(
          backgroundColor: Colors.white,
          bottomSheet: _bottomsheet(context),
          appBar: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.white,
            elevation: 10.0,
            title: Text(name,style: TextStyle(color: Colors.blue[600],fontWeight: FontWeight.w400),),
            centerTitle: true,
            leading: Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.blue,
                  child: ClipOval(
                      child: (image != null)
                          ? Image.network(image)
                          :  CircleAvatar(
                        radius: 19.0,
                        backgroundColor: Colors.white,
                        backgroundImage:
                        ExactAssetImage('assets/images/google.png'),
                        //getProperImageProviderForConnectionsCollection(
                        //    _userName),
                      )
                  ),
                ),
              ],
            ),

          ),
          body: LoadingOverlay(
            isLoading: this._isLoading,
            color: Colors.white,
            child: Center(),
          ),
        ),
      ),
    );
  }

  Widget _bottomsheet(context) {
  return Container(
    width: double.maxFinite,
    height: 80.0,
    decoration: BoxDecoration(
        color: const Color.fromRGBO(25, 39, 52, 1),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
    child: Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.emoji_emotions_outlined,
            color: Colors.amber,
          ),
          onPressed: () {



            print('Clicked Emoji');
            if (mounted) {
              setState(() {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                this._showEmojiPicker = true;
                // this._chatBoxHeight -= 300;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: GestureDetector(
            child: Icon(
              FontAwesomeIcons.link,
              color: Colors.lightBlue,
            ),
            // onTap: _differentChatOptions,
          ),
        ),
        Expanded(
          child: SizedBox(
            width: double.maxFinite,
            height: 60.0,
            child: TextField(
              controller: this._typedText,
              style: TextStyle(color: Colors.white),
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Type here',
                hintStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
                ),
              ),
              onTap: () {
                if (mounted) {
                  setState(() {
                    // this._chatBoxHeight += 300;
                    this._showEmojiPicker = false;
                  });
                }
              },
              onChanged: (writeText) {
                bool _isEmpty = false;
                writeText.isEmpty ? _isEmpty = true : _isEmpty = false;

                if (mounted) {
                  setState(() {
                    this._writeTextPresent = !_isEmpty;
                  });
                }
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: GestureDetector(
            child: this._writeTextPresent
                ? Icon(
              Icons.send,
              color: Colors.green,
              size: 30.0,
            )
                : Icon(
              Icons.keyboard_voice_rounded,
              color: Colors.green,
              size: 30.0,
            ),
            // onTap: this._writeTextPresent ? _sendText : _voiceTake,
          ),
        ),
      ],
    ),
  );
}

}


