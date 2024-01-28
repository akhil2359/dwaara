// basic statelss widget

import 'package:Dwaara/components/combination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/items.dart';
import '../controllers/user_controller.dart';

class Matching extends StatefulWidget {
  const Matching({Key? key}) : super(key: key);

  @override
  State<Matching> createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Obx(() =>
                  Combination(combination: userController.combination.value, context: context))
            ],
          ),
        ],
      ),
    );
  }
}
