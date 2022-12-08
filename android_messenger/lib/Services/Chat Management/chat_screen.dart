
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:animations/animations.dart';
import 'package:circle_list/circle_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';


enum ChatMessageTypes {
  None,
  Text,
  Image,
  Video,
  Document,
  Audio,
  Location,
}

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


  List<Map<String, String>> _allConversationMessages = [
    {
      'Hi': '08:45',
      'Hello': '08:46',
      'How are you?': '08:50',
      'Im good': '08:55',


    }
  ];


  List<bool> _conversationMessageHolder = [true,false];
  List<ChatMessageTypes> _chatMessageCategoryHolder = [];

  bool _lastDirection = false;

  late String name = widget.userName;
  late String about = widget.about;
  late String image = widget.image;


  final TextEditingController _typedText = TextEditingController();
  late String messagetime = '08:45';

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
                Container(
                  width: 30,
                  height: 30,
                  child: CircleAvatar(
                    radius: 32.0,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                        child: Container(
                          height: 80,
                          width: 80,
                          child: (image != null)
                              ? Image.network(image)
                              :  CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.white,
                            backgroundImage:
                            ExactAssetImage('assets/images/google.png'),
                            //getProperImageProviderForConnectionsCollection(
                            //    _userName),
                          ),

                        )
                    ),
                  ),
                )
              ],
            ),

          ),
          body: LoadingOverlay(
            isLoading: this._isLoading,
            color: Colors.white,
            child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  //margin: EdgeInsets.all(12.0),
                  child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: this._allConversationMessages.length,
                    itemBuilder: (itemBuilderContext, index){
                    return textCoversationManagement(itemBuilderContext, index);
                    },


                  )
          ),
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
            onTap:(){
              if(this._writeTextPresent)
                {
                  final String messagetime = "${DateTime.now().hour }: ${DateTime.now().minute }";
                  if(mounted)
                    {
                      this._allConversationMessages.add(
                        {
                          this._typedText.text:this.messagetime
                        }
                      );

                      this._conversationMessageHolder.add(this._lastDirection);
                      if(this._lastDirection==false)
                        {
                          this._lastDirection = true;
                        }
                      else
                        this._lastDirection = false;
                      this._typedText.clear();
                    }
                }
          }
          ),
        ),
      ],
    ),
  );
}

  Widget textCoversationManagement(BuildContext itemBuilderContext, int index) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: this._conversationMessageHolder[index]
              ? EdgeInsets.only(
            right: MediaQuery.of(context).size.width / 3,
            left: 5.0,
          )
              : EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 3,
            right: 5.0,
          ),
          alignment: this._conversationMessageHolder[index]
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: this._conversationMessageHolder[index]
                  ? Color.fromRGBO(60, 80, 100, 1)
                  : Color.fromRGBO(102, 102, 255, 1),
              elevation: 0.0,
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: this._conversationMessageHolder[index]
                      ? Radius.circular(0.0)
                      : Radius.circular(20.0),
                  topRight: this._conversationMessageHolder[index]
                      ? Radius.circular(20.0)
                      : Radius.circular(0.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            ),
            child: Text(
              this._allConversationMessages[index].keys.first,
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            onPressed: () {},
            onLongPress: () {},
          ),
        ),

        _conversationMessageTime(
            this._allConversationMessages[index].values.first, index),
      ],
    );
  }
  Widget _conversationMessageTime(String time, int index) {
    return Container(
      alignment: this._conversationMessageHolder[index]
          ? Alignment.centerLeft
          : Alignment.centerRight,
      margin: this._conversationMessageHolder[index]
          ? const EdgeInsets.only(
        left: 5.0,
        bottom: 5.0,
        top: 2.0,
      )
          : const EdgeInsets.only(
        right: 5.0,
        bottom: 5.0,
        top: 2.0,
      ),
      child: _timeReFormat(time),
    );
  }
}
Widget _timeReFormat(String _willReturnTime) {
  if (int.parse(_willReturnTime.split(':')[0]) < 10)
    _willReturnTime = _willReturnTime.replaceRange(
        0, _willReturnTime.indexOf(':'), '0${_willReturnTime.split(':')[0]}');

  if (int.parse(_willReturnTime.split(':')[1]) < 10)
    _willReturnTime = _willReturnTime.replaceRange(
        _willReturnTime.indexOf(':') + 1,
        _willReturnTime.length,
        '0${_willReturnTime.split(':')[1]}');

  return Text(
    _willReturnTime,
    style: TextStyle(color: Colors.blue[400],fontSize: 10),
  );
}

