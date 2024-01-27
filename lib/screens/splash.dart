import 'package:Dwaara/screens/home.dart';
import 'package:Dwaara/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import '../services/firestore.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 1), () {
        checkCurrentUser();
      });
    });
  }

  Future<void> checkCurrentUser() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("user is already logged in");
      // PRINT USER ID
      print(user.uid);
      updateUser(user);
    } else {
      Get.offAll(Login());
      print("user is not logged in");
    }
  }

  void updateUser(User user) async {
    final String userId = user.uid ?? '';
    final String username = user.displayName ?? '';
    final String email = user.email ?? '';
    final String profilepicture = user.photoURL ?? '';

    userController.updateUid(userId);
    userController.updateName(username);
    userController.updateEmail(email);
    userController.updateImageUrl(profilepicture);

    createRecordInUserCollection(userId, username, email, profilepicture);

    if (mounted) {
      Get.offAll(Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Hero(
            tag: 'logo',
            child: Image(image: AssetImage('assets/icon/logo.png')),
          ),
        ),
      ),
    );
  }
}
