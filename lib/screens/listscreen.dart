import 'package:Dwaara/screens/imageView.dart';
import 'package:Dwaara/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class ListScreen extends StatefulWidget {
  final List items;
  final String title;
  final BuildContext context;

  const ListScreen(
      {Key? key,
      required this.items,
      required this.title,
      required this.context})
      : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  UserController userController = Get.put(UserController());

  List<String> get currentList {
    // Check the title and return the appropriate list from userController
    if (widget.title == "Shirts") {
      return userController.shirts.value;
    } else if (widget.title == "Pants") {
      return userController.pants.value;
    } else if (widget.title == "Shoes") {
      return userController.shoes.value;
    } else if (widget.title == "Accessories") {
      return userController.accessories.value;
    } else {
      return [];
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              showImagePickerDialog(context, widget.title);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: ((currentList.length) / 2).ceil(),
          itemBuilder: (context, index) {
            int startIndex = index * 2;
            int endIndex = startIndex + 1;

            print(
                "Index: $index, StartIndex: $startIndex, EndIndex: $endIndex, List length: ${currentList.length}");

            return Row(
              children: [
                if (startIndex < currentList.length)
                  Expanded(
                    child: buildImageCard(currentList[startIndex]),
                  ),
                SizedBox(width: 8),
                if (endIndex < currentList.length)
                  Expanded(
                    child: buildImageCard(currentList[endIndex]),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildImageCard(String itemImage) {
    if (itemImage.isEmpty) {
      return Container();
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          widget.context,
          MaterialPageRoute(
            builder: (context) => ImageView(itemImage),
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Container(
              child: CachedNetworkImage(
                imageUrl: itemImage,
                fit: BoxFit.cover,
                width: MediaQuery.of(widget.context).size.width,
                height: 200.0,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

