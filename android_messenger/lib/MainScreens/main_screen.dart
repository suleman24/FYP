import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Services/search_screen.dart';
import '../auth/authentication.dart';
import '../auth/check.dart';
import 'MenuScreens/profile_screen.dart';
import 'chatAndActivityScreen.dart';
import 'general_connection_section.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final _drawerController = ZoomDrawerController();

  late String name = 'hello';
  late String image = '0';
  late String about = '';
  late String createdate = '';
  late String createtime = '';
  late String email = '';
  late String tempimg = '';




    int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        child: WillPopScope(
          onWillPop: () async {
            if (_currIndex > 0)
              return false;
            else {
              return true;
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,

            floatingActionButton: FloatingActionButton(
              child: Icon(
                FontAwesomeIcons.plus
              ),
              onPressed: () async{


                final uid = await AuthenticationHelper().getID();

                print(uid);


                var data = await FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: uid)
                    .get();

                email= data.docs[0]['email'];


                Navigator.push(context, MaterialPageRoute(builder: (context)=>searchscreen(email:email
                )));
              },
            ),
            drawer: _drawer(),

            appBar: AppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.blue[500],
              elevation: 10.0,
              shadowColor: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
                side: BorderSide(width: 0.7),
              ),
              title: Text(
                "Suzo",
                style: TextStyle(
                    fontSize: 25.0, fontFamily: 'Lora', letterSpacing: 1.0,color: Colors.white),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.search_outlined,
                    size: 25.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 20.0,
                  ),
                  child: IconButton(
                    tooltip: 'Refresh',
                    icon: Icon(
                      Icons.refresh_outlined,
                      size: 25.0,
                    ),
                    onPressed: () async {


                    },
                  ),
                ),

              ],
              bottom: _bottom(),
            ),


            body: TabBarView(
              children: [

                ChatAndActivityScreen(),
                // LogsCollection(),
                GeneralMessagingSection(),
              ],
            ),
          ),
        )

    );
  }







    TabBar _bottom() {
      return TabBar(
        indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: Colors.lightBlue),
            insets: EdgeInsets.symmetric(horizontal: 15.0)),
        automaticIndicatorColorAdjustment: true,
        labelStyle: TextStyle(
          fontFamily: 'Lora',
          fontWeight: FontWeight.w500,
          letterSpacing: 1.0,
        ),
        onTap: (index) {
          print("\nIndex is: $index");
          if (mounted) {
            setState(() {
              _currIndex = index;
            });
          }
        },
        tabs: [
          Tab(
            child: Text(
              "Chats",
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Lora',
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
                color: Colors.white
              ),
            ),
          ),
          // Tab(
          //   child: Text(
          //     "Logs",
          //     style: TextStyle(
          //       fontSize: 20.0,
          //       fontFamily: 'Lora',
          //       fontWeight: FontWeight.w500,
          //       letterSpacing: 1.0,
          //         color: Colors.white
          //
          //     ),
          //   ),
          // ),
          Tab(
            icon: Icon(
              Icons.store,
              size: 25.0, color: Colors.white
            ),
          ),
        ],
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
                radius: MediaQuery.of(context).orientation ==
                    Orientation.portrait
                    ? MediaQuery.of(context).size.height *
                    (1.2 / 8) /
                    2.5
                    : MediaQuery.of(context).size.height *
                    (2.5 / 8) /
                    2.5,
                child: ClipOval(
                    child: Container(
                      height: 80,
                      width: 80,
                      child: (image != "0")
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

            ),

          ),

        ],
      ),
    );
  }



  Widget _drawer(){
    return Drawer(
      elevation: 10,
      backgroundColor: Colors.blue,

      child: Container(
        color: Colors.blue,

        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 250.0,
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(blurRadius: 40.0)
                ],
                borderRadius: new BorderRadius.vertical(
                    bottom: new Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0)),
              ),

              child: Column(
                children: [

                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {


                    },
                    child: Center(
                        child: profilepic()
                    ),

                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(child:
                  Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: Colors.blue[700]),)
                    ,),
                ],
              ),
            ),



            SizedBox(
              height: 50.0,
            ),
            GestureDetector(
                onTap: () async{
                  final uid = await AuthenticationHelper().getID();

                  print(uid);


                  var data = await FirebaseFirestore.instance
                      .collection('users')
                      .where('uid', isEqualTo: uid)
                      .get();

                  name = data.docs[0]['user_name'];
                  email= data.docs[0]['email'];
                  image = data.docs[0]['profile_pic'];
                  tempimg = data.docs[0]['tempimg'];
                  about = data.docs[0]['about'];
                  createdate = data.docs[0]['creation_date'];
                  createtime = data.docs[0]['creation_time'];


                  print(name);
                  print(email);


                  Navigator.push(context, MaterialPageRoute(builder: (context)=>profilescreen(
                    name: name,
                    about: about,
                    image: image,
                    email: email,
                    createdate: createdate,
                    createtime: createtime,
                    tempimg: tempimg,
                  )));



                },
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5,),
                        Text('Profile',style: TextStyle(color: Colors.white,fontSize: 18),),
                      ],
                    )
                )

            ),
            SizedBox(
              height: 30.0,
            ),
            // _menuOptions(Icons.settings, 'Setting'),
            // SizedBox(
            //   height: 10.0,
            // ),

            GestureDetector(
                onTap: () async{


                },
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.mailForward,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5,),
                        Text('Support',style: TextStyle(color: Colors.white,fontSize: 18),),
                      ],
                    )
                )

            ),

            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
                onTap: () async{


                },
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.description_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5,),
                        Text('About',style: TextStyle(color: Colors.white,fontSize: 18),),
                      ],
                    )
                )

            ),

            SizedBox(
              height: 30.0,
            ),
            logout(),
          ],
        ),
      ),
    );
    }



  Widget logout() {
    return GestureDetector(
      onTap: () async {
        AuthenticationHelper().signOut(context);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Check()));
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(0,20, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
  }













