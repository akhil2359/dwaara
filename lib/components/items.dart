import 'dart:io';

import 'package:Dwaara/screens/imageView.dart';
import 'package:Dwaara/screens/listscreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firestore.dart';

class Items extends StatelessWidget {
  const Items(
      {Key? key,
      required this.items,
      required this.name,
      required this.context})
      : super(key: key);

  final List items;
  final String name;
  final BuildContext context;

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
              // show view all only if items are greater than 4
              if (items.length > 4)
                TextButton(
                  onPressed: () {
                    // Open the List screen when "View All" is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Container(
                          child: ListScreen(
                            items: items,
                            title: name,   
                            context: context,
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
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
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageView(items[index]),
                        ),
                      );
                    },
                    child: Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 26),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(items[index]),
                          fit: BoxFit.cover,
                        ),
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
                          onPressed: () {
                            showImagePickerDialog(context, name);
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
