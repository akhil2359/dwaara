// ignore_for_file: invalid_use_of_protected_member

import 'package:Dwaara/components/items.dart';
import 'package:Dwaara/controllers/user_controller.dart';
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
        leading: Image.asset("assets/icon/logo.png"),
        title: const Text(
          Home._title,
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
  child: Column(
    children: [
      Column(
        children: [
          Obx(() => Items(items: userController.shirts.value, name: 'Shirts')),
          Obx(() => Items(items: userController.pants.value, name: 'Pants')),
          Obx(() => Items(items: userController.shoes.value, name: 'Shoes')),
          Obx(() => Items(items: userController.accessories.value, name: 'Accessories')),
        ],
      ),
    ],
  ),
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
