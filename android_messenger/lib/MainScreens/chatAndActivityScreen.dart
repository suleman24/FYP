import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:animations/animations.dart';

import '../Services/Chat Management/chat_screen.dart';


class ChatAndActivityScreen extends StatefulWidget {
  const ChatAndActivityScreen({Key? key}) : super(key: key);

  @override
  State<ChatAndActivityScreen> createState() => _ChatAndActivityScreenState();
}

class _ChatAndActivityScreenState extends State<ChatAndActivityScreen> {

  bool _isLoading = false;
  final List<String> _allUserConnectionActivity = ['Suleman', 'Tayyeb'];
  final List<String> _allConnectionsUserName = ['Suleman','Bilal', 'Tayyeb'];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: LoadingOverlay(
            color: const Color.fromRGBO(0, 0, 0, 0.5),
            progressIndicator: const CircularProgressIndicator(
              backgroundColor: Colors.white38,
            ),
            isLoading: this._isLoading,
            child: ListView(
              children: [
                _activityList(context),
                _connectionList(context),
              ],
            ),
          ),


        ));
  }


  Widget _activityList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 10.0,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * (1.5 / 8)
          : MediaQuery.of(context).size.height * (3 / 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Make ListView Horizontally
        itemCount: _allUserConnectionActivity.length,
        itemBuilder: (context, position) {
          return _activityCollectionList(context, position);
        },
      ),
    );
  }



  Widget _activityCollectionList(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 18),
      padding: EdgeInsets.only(top: 3.0),
      height: MediaQuery.of(context).size.height * (1.5 / 8),
      child: Column(
        children: [
          Stack(
            children: [
              if (_allUserConnectionActivity[index]
                  .contains('[[[new_activity]]]'))
                Container(
                  height:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? (MediaQuery.of(context).size.height *
                      (1.2 / 7.95) /
                      2.5) *
                      2
                      : (MediaQuery.of(context).size.height *
                      (2.5 / 7.95) /
                      2.5) *
                      2,
                  width:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? (MediaQuery.of(context).size.height *
                      (1.2 / 7.95) /
                      2.5) *
                      2
                      : (MediaQuery.of(context).size.height *
                      (2.5 / 7.95) /
                      2.5) *
                      2,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    value: 1.0,
                  ),
                ),
              OpenContainer(
                closedColor: const Color.fromRGBO(34, 48, 60, 1),
                openColor: const Color.fromRGBO(34, 48, 60, 1),
                middleColor: const Color.fromRGBO(34, 48, 60, 1),
                closedElevation: 0.0,
                closedShape: CircleBorder(),
                transitionDuration: Duration(
                  milliseconds: 500,
                ),
                transitionType: ContainerTransitionType.fadeThrough,
                openBuilder: (context, openWidget) {
                  return Center();
                },
                closedBuilder: (context, closeWidget) {
                  return CircleAvatar(
                    backgroundColor: Colors.pink,
                    radius: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? MediaQuery.of(context).size.height * (1.2 / 8) / 3.3
                        : MediaQuery.of(context).size.height * (2.5 / 8) / 3.3,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                      ExactAssetImage('assets/images/google.png'),
                      radius: MediaQuery.of(context).orientation ==
                          Orientation.portrait
                          ? MediaQuery.of(context).size.height * (1.2 / 8) / 3.5
                          : MediaQuery.of(context).size.height * (2.5 / 8) / 3.5,
                    ),
                  );
                },
              ),
              index == 0 // This is for current user Account
                  ? Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).orientation ==
                      Orientation.portrait
                      ? MediaQuery.of(context).size.height * (0.7 / 8) -
                      10
                      : MediaQuery.of(context).size.height * (1.5 / 8) -
                      10,
                  left: MediaQuery.of(context).orientation ==
                      Orientation.portrait
                      ? MediaQuery.of(context).size.width / 3 - 65
                      : MediaQuery.of(context).size.width / 8 - 15,
                ),
                child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.lightBlue,
                    ),
                    child: GestureDetector(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? MediaQuery.of(context).size.height *
                            (1.3 / 8) /
                            2.5 *
                            (3.5 / 6)
                            : MediaQuery.of(context).size.height *
                            (1.3 / 8) /
                            2,
                      ),
                    )),
              )
                  : const SizedBox(),
            ],
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 7.0,
            ),
            child: Text(
              'Suzo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }










  Widget _connectionList(BuildContext context) {
    return LoadingOverlay(
      isLoading: this._isLoading,
      child: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).orientation == Orientation.portrait
                ? 5.0
                : 0.0),
        padding: const EdgeInsets.only(top: 18.0, bottom: 30.0),
        height: MediaQuery.of(context).size.height * (5.15 / 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: const Offset(0.0, -5.0), // shadow direction: bottom right
            )
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          border: Border.all(
            color: Colors.cyan,
            width: 1.0,
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),

          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Center(
              child: CircularProgressIndicator(),);

            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: CardList(snapshot: snapshot.data,index: index,),
                  );
                });

          },
        )
      ),
    );
  }

}









class CardList extends StatefulWidget {
  CardList({required this.snapshot,required this.index, this.email,});
  final QuerySnapshot snapshot;
  final int index;
  final email;

  String buttonmsg = 'Request';

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {


  @override
  Widget build(BuildContext context) {
    var about=widget.snapshot.docs[widget.index]['about'];
    var name = widget.snapshot.docs[widget.index]['user_name'];
    var image = widget.snapshot.docs[widget.index]['profile_pic'];
    var email = widget.snapshot.docs[widget.index]['email'];


    return Card(
        elevation: 3.0,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),

        ),
        color: Colors.white38,


        child: Container(

          //padding: EdgeInsets.only(left: 1.0, right: 1.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary: Colors.white,
              onPrimary: Colors.lightBlueAccent,
            ),
            onPressed: () {
              print("Chat List Pressed");
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                  ),
                  child: OpenContainer(
                    closedColor: Colors.white,
                    openColor: Colors.white,
                    middleColor: Colors.white,
                    closedShape: CircleBorder(),
                    closedElevation: 0.0,
                    transitionDuration: Duration(milliseconds: 500),
                    transitionType: ContainerTransitionType.fadeThrough,
                    openBuilder: (_, __) {
                      return Center();
                    },
                    closedBuilder: (_, __) {
                      return Container(
                        width: 50,
                        height: 50,
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
                      );
                    },
                  ),
                ),
                OpenContainer(
                  closedColor: Colors.white,
                  openColor: Colors.white,
                  middleColor: Colors.white,
                  closedElevation: 0.0,
                  openElevation: 0.0,
                  transitionDuration: Duration(milliseconds: 500),
                  transitionType: ContainerTransitionType.fadeThrough,
                  openBuilder: (context, openWidget) {
                    return chatscreen(userName: name,about:about,image:image);


                    //   ChatScreen(
                    //   userName: _userName,
                    // );
                  },
                  closedBuilder: (context, closeWidget) {
                    return Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2 + 30,
                      padding: EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                        left: 5.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            name.length <= 16
                                ? name
                                : '${name.replaceRange(16, name.length, '...')}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue[900],
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),

                          Text(
                            about,
                            style: TextStyle(color: Colors.blue[500]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                      top: 2.0,
                      bottom: 2.0,
                    ),
                    child: Column(
                      children: [
                        Text('12:00'),
                        SizedBox(
                          height: 10.0,
                        ),
                        Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

}


