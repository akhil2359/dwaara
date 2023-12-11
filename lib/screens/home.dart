import 'package:Dwaara/components/items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const String _title = 'Dwaara';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  String username = "";
  String email = "";
  String profilepicture = "";
  String uid = "";

  List<String> shirtsList = [];
  List<String> pantsList = [];
  List<String> shoesList = [];
  List<String> accessoriesList = [];

  // init state
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    // get user details from firestore
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic>? data = userDoc.data();
      print("xxxdataxxx");
      print(data);
      if (data != null) {
        // check if shirs, pants, shoes, accessories are not null
        if (data['shirts'] != null) {
          setState(() {
            shirtsList = data['shirts'].cast<String>();
          });
        }
        if (data['pants'] != null) {
          pantsList = data['pants'].cast<String>();
        }
        if (data['shoes'] != null) {
          shoesList = data['shoes'].cast<String>();
        }
        if (data['accessories'] != null) {
          accessoriesList = data['accessories'].cast<String>();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // logo leading from assets
        leading: Image.asset("assets/icon/logo.png"),
        title: const Text(
          Home._title,
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Items(items: shirtsList, name: 'Shirts'),
          Items(items: pantsList, name: 'Pants'),
          Items(items: shoesList, name: 'Shoes'),
          Items(items: accessoriesList, name: 'Accessories'),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.shirt),
            label: '',
          ),
          // item with circle avatar with profile picture url from args , if empty add letters of name
          BottomNavigationBarItem(
            icon: profilepicture.isNotEmpty
                ? CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(profilepicture),
                  )
                : CircleAvatar(
                    radius: 15,
                    backgroundColor:
                        Colors.blue, // Set a background color of your choice
                    child: Text(
                      username.isNotEmpty ? username[0].toUpperCase() : '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
