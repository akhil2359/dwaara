// basic horizontal card scroll view widget for displaying items , get items from params and display them

import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  const Items({Key? key, required this.items, required this.name})
      : super(key: key);

  final List<Map<String, dynamic>> items;
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
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            height: 160,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 26),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
