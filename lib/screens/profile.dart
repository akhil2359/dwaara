import 'package:Dwaara/controllers/user_controller.dart';
import 'package:Dwaara/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          userController.imageurl.isNotEmpty
              ? CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userController.imageurl.value),
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
          const SizedBox(height: 20),
          Center(
            child: Text(
              userController.name.value,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            userController.email.value,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                await signOut(context);
              },
              child: Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
        ],
      ),
    );
  }
}

Future<void> signOut(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  try {
    await googleSignIn.signOut();
    await auth.signOut(); 
    userController.resetAllStates();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.offAll(Login());
    });
  } catch (e) {
    print("Sign out failed: $e");
  }
}
