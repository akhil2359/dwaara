import 'package:Dwaara/screens/home.dart';
import 'package:Dwaara/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const Login(),
        '/login': (BuildContext context) =>  Login(),
        '/home': (BuildContext context) => const Home(),
      },
    );
  }
}
