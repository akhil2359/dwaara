import 'package:Dwaara/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// user controller
UserController userController = Get.put(UserController());
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
