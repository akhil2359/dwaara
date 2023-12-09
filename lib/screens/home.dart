import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const String _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: const Center(
        child: Text(
          'Home',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}