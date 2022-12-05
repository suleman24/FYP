import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';


class searchscreen extends StatefulWidget {
  const searchscreen({Key? key, this.email}) : super(key: key);

  final email;

  @override
  _searchscreenState createState() => _searchscreenState();
}

class _searchscreenState extends State<searchscreen> {
  List<Map<String, dynamic>> _availableUsers = [];
  List<Map<String, dynamic>> _sortedAvailableUsers = [];
  List<dynamic> _myConnectionRequestCollection = [];

  bool _isLoading = false;

  late var email = widget.email;

  Future<void> _initialDataFetchAndCheckUp() async {
    if (mounted) {
      setState(() {
        this._isLoading = true;
      });
    }

    if (mounted) {
      setState(() {
        this._isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _initialDataFetchAndCheckUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: this._isLoading,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),

                  child: Center(
                    child: Text('Available Users',
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.blue[900]),),
                  ),
                ),

                Container(
                  height: 800,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                              child: CardList(snapshot: snapshot.data,index: index,email:email),
                            );
                          });

                    },
                  ),
                )

              ],
            ),
          ),
        ),
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
    var recieveremail = widget.snapshot.docs[widget.index]['email'];

    var buttonmsg = widget.buttonmsg;
    late var email = widget.email;


    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),

      child: Card(
        elevation: 3.0,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),

        ),
        color: Colors.white,

        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(55))
              ),
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
            ),
            Container(
              alignment: Alignment.center,
              width: 200,
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
                    about.length <= 18
                        ? about
                        : '${about.replaceRange(18, about.length, '...')}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blue[500],
                    ),
                  ),
                ],
              ),
            ),

            Card(
              elevation: 3.0,
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),

              ),
              color: Colors.white,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.transparent,
                  onPrimary: Colors.lightBlueAccent,
                ),
                onPressed: () {
                  setState(() {
                    buttonmsg = 'Pending';
                  });
                  print(buttonmsg);


                },
                child: Text(
                  buttonmsg,
                )
              ),
            )

          ],
        ),
      ),

    );
  }

}



