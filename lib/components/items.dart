import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Items extends StatelessWidget {
  const Items({Key? key, required this.items, required this.name})
      : super(key: key);

  final List<String> items;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                name + " (" + items.length.toString() + ")",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              // show view all if items length is greater than 3
              if (items.length > 3)
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )
              else
                const SizedBox(height: 40),
            ],
          ),
          Container(
            height: 160,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index < items.length) {
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 26),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                      image: DecorationImage(
                        image: Image.network(items[index]).image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 26),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add_a_photo,
                              size: 30, color: Colors.grey),
                          onPressed: () async {
                            // 1. Get image path using image_picker from camera
                            ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.camera);
                            if (image == null) {
                              print(">>>>image is null");
                              return;
                            }
                            ;
                            print("image path is: ");
                            print(image!.path);
                            try {
                              if (FirebaseStorage.instance.app == null) {
                                print(
                                    ">>>Firebase Storage is not initialized.");
                              } else {
                                // 2. Get a reference to storage root
                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference referenceDirImages =
                                    referenceRoot.child(name.toLowerCase());

                                // 3. Create a reference for the image to be stored
                                Reference referenceImage = referenceDirImages
                                    .child(image.path.split('/').last);

                                // 4. Store the image
                                await referenceImage.putFile(File(image.path));
                                // 5. Get the image URL
                                String imageUrl =
                                    await referenceImage.getDownloadURL();
                                print(">>>>image url is: ");
                                print(imageUrl);
                                createRecordInUserCollection(
                                    imageUrl, name.toLowerCase());
                              }
                            } catch (e) {
                              print(">>>>error uploading image: $e");
                            }
                          },
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Add ' + name,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

void createRecordInUserCollection(imageUrl, collectionName) async {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
        .then((value) => print("Image added to $collectionName field"))
        .catchError((error) =>
            print("Failed to add image to $collectionName field: $error"));
  } catch (e) {
    print(e);
  }
}
