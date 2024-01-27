import 'package:Dwaara/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:Dwaara/screens/imageView.dart';
import 'package:Dwaara/screens/listscreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firestore.dart';

// user controller
UserController userController = Get.put(UserController());


  Future<void> _uploadImage(XFile image, String name) async {
    try {
      if (FirebaseStorage.instance.app == null) {
        print(">>>Firebase Storage is not initialized.");
        return;
      }

      // Get a reference to storage root
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child(name.toLowerCase());

      // Create a reference for the image to be stored
      Reference referenceImage =
          referenceDirImages.child(image.path!.split('/').last);

      // Store the image
      await referenceImage.putFile(File(image.path!));

      // Get the image URL
      String imageUrl = await referenceImage.getDownloadURL();
      print(">>>>image url is: ");
      print(imageUrl);

      if (name == "Shirts") {
        userController.appendShirt(imageUrl);
      } else if (name == "Pants") {
        userController.appendPants(imageUrl);
      } else if (name == "Shoes") {
        userController.appendShoes(imageUrl);
      } else if (name == "Accessories") {
        userController.appendAccessories(imageUrl);
      }
      createCollectionInUserCollection(imageUrl, name.toLowerCase());
    } catch (e) {
      print(">>>>error uploading image: $e");
    }
  }

  Future<void> _getImage(ImageSource source, String name) async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: source);

      if (image == null) {
        print(">>>>image is null");
        return;
      }

      print("image path is: ");
      print(image.path);

      await _uploadImage(image, name);
    } catch (e) {
      print(">>>>error getting image: $e");
    }
  }

  Future<void> showImagePickerDialog(context, name) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImage(ImageSource.gallery, name);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImage(ImageSource.camera, name);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }


Future<void> createRecordInUserCollection(
    String uid, String name, String email, String profilePicture) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(uid).set(
      {
        'name': name,
        'email': email,
        'profilepicture': profilePicture,
      },
      SetOptions(merge: true),
    );
    print("User Added");
    // check if shirts, pants, shoes, accessories are already present, if present update controller
    // if not present, create empty array
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
    print("Failed to add user: $e");
  }
}

void createCollectionInUserCollection(imageUrl, collectionName) async {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  print("collection name is " + collectionName);
  FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user!.uid;
  // try and catch user creation, check if already exists and update if so
  try {
    // add colllectionname withing users collection
    await users
        .doc(uid)
        .update({
          collectionName: FieldValue.arrayUnion([imageUrl]),
        })
        .then((value) => {
          print("xxx added image to firestore")
              // update in usercontroller based on collection name
             
            })
        .catchError((error) =>
            print("Failed to add image to $collectionName field: $error"));
  } catch (e) {
    print(e);
  }
}
