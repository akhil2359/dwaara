// ignore_for_file: invalid_use_of_protected_member

import 'package:Dwaara/components/items.dart';
import 'package:Dwaara/controllers/user_controller.dart';
import 'package:Dwaara/screens/matching.dart';
import 'package:Dwaara/screens/profile.dart';
import 'package:Dwaara/screens/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const String _title = 'Dwaara';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  UserController userController = Get.put(UserController());

  List bottomNavigatorOptions = [
    {
      'title': 'Outfits',
      'widget': Matching(),
    },
    {
      'title': 'Wardobe',
      'widget': Upload(),
    },
    {
      'title': 'Profile',
      'widget': Profile(),
    },
  ];
   

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getUserDetails();
    });
  }

  void getUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String uid = user.uid;
      try {
        final DocumentSnapshot<Map<String, dynamic>> userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        final Map<String, dynamic>? data = userDoc.data();
        print("xxxdataxxx");
        print(data);
        if (data != null) {
          if (data['shirts'] != null) {
            userController.updateShirts(data['shirts'].cast<String>());
          }
          if (data['pants'] != null) {
            userController.updatePants(data['pants'].cast<String>());
          }
          if (data['shoes'] != null) {
            userController.updateShoes(data['shoes'].cast<String>());
          }
          if (data['accessories'] != null) {
            userController.updateAccessories(data['accessories'].cast<String>());
          }
        }
      } catch (e) {
        print("Error fetching user details: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Hero(tag: 'logo', child: Image.asset("assets/icon/logo.png")),
        title:  Text(
          bottomNavigatorOptions[_selectedIndex]['title'] as String,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: bottomNavigatorOptions[_selectedIndex]['widget'] as Widget,
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.shirt),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: userController.imageurl.isNotEmpty
                    ? CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            NetworkImage(userController.imageurl.value),
                      )
                    : CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Text(
                          userController.name.isNotEmpty
                              ? userController.name.value.substring(0, 1)
                              : '',
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
          )),
    );
  }
}
