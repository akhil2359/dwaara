import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const String _title = 'Home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

String username = "";
  String email = "";
  String profilepicture = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Map<String, dynamic>? args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          username = args['username'] as String;
          email = args['email'] as String;
          profilepicture = args['profilepicture'] as String;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Home._title)),
      body:  Center(
        child: Text(
          'name is $username email is $email profile picture is $profilepicture',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}