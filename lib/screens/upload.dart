// basic statelss widget

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/items.dart';
import '../controllers/user_controller.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Obx(() =>
                  Items(items: userController.shirts.value, name: 'Shirts')),
              Obx(() =>
                  Items(items: userController.pants.value, name: 'Pants')),
              Obx(() =>
                  Items(items: userController.shoes.value, name: 'Shoes')),
              Obx(() => Items(
                  items: userController.accessories.value,
                  name: 'Accessories')),
            ],
          ),
        ],
      ),
    );
  }
}
