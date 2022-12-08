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
  const MainScreen({Key? key, this.name}) : super(key: key);
  final name;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final _drawerController = ZoomDrawerController();

  late String name = widget.name;
  late String image = '0';
  late String about = '';
  late String createdate = '';
  late String createtime = '';
  late String email = '';
  late String tempimg = '';

  bool sfield = false;



    int _currIndex = 0;

    @override


    void searchfieldopen()
    {
      setState(() {
        sfield = true;
      });
    }
  void searchfieldclose()
  {
    setState(() {
      sfield = false;
    });
  }


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
              child: const Icon(
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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
                side: BorderSide(width: 0.7),
              ),
              title: Text(
                sfield==false?
                "Suzo":'',
                style: TextStyle(
                    fontSize: 25.0, fontFamily: 'Lora', letterSpacing: 1.0,color: Colors.white),
              ),
              actions: [

                if(sfield==true)
                  SizedBox(
                    width: 300,
                    height: 10,
                    child: TextFormField(
                      style: TextStyle(color: Colors.blue[900]),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                            const BorderSide(width: 0.5, color: Colors.blue)),

                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.blue[900]),

                      ),

                    ),
                  ),

                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: IconButton(

                    onPressed: (){
                      if(sfield == false)
                        searchfieldopen();
                      else
                        searchfieldclose();
                    },
                    icon: Icon(
                      Icons.search_outlined,
                      size: 25.0,
                    ),
                  ),
                ),

              ],
              bottom: _bottom(),
            ),


            body: const TabBarView(
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
        indicatorPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: Colors.lightBlue),
            insets: EdgeInsets.symmetric(horizontal: 15.0)),
        automaticIndicatorColorAdjustment: true,
        labelStyle: const TextStyle(
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
          const Tab(
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
          const Tab(
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
            margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(55))
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
                          :  const CircleAvatar(
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

                  const SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {


                    },
                    child: Center(
                        child: profilepic()
                    ),

                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Center(child:
                  Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: Colors.blue[700]),)
                    ,),
                ],
              ),
            ),



            const SizedBox(
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
                        const Icon(
                          Icons.person_outline_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5,),
                        const Text('Profile',style: TextStyle(color: Colors.white,fontSize: 18),),
                      ],
                    )
                )

            ),
            const SizedBox(
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
                        const Icon(
                          FontAwesomeIcons.mailForward,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5,),
                        const Text('Support',style: TextStyle(color: Colors.white,fontSize: 18),),
                      ],
                    )
                )

            ),

            const SizedBox(
              height: 30.0,
            ),
            GestureDetector(
                onTap: () async{


                },
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.description_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5,),
                        const Text('About',style: TextStyle(color: Colors.white,fontSize: 18),),
                      ],
                    )
                )

            ),

            const SizedBox(
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

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Check(name: '',)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,20, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text(
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













