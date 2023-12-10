import 'package:Dwaara/components/items.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const String _title = 'Dwaara';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        // logo leading from assets
        leading: Image.asset("assets/icon/logo.png"),
        title: const Text(
          Home._title,
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:
          // scrollview vertical
          SingleChildScrollView(
        child: Column(children: [
          Items(name: 'Shirts', items: [
            {
              "name": "item1",
              "price": 100,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item2",
              "price": 200,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item3",
              "price": 300,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item4",
              "price": 400,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item5",
              "price": 500,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item6",
              "price": 600,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item7",
              "price": 700,
              "image": "https://picsum.photos/200/300"
            }
          ]),
          Items(name: 'Pants', items: [
            {
              "name": "item1",
              "price": 100,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item2",
              "price": 200,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item3",
              "price": 300,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item4",
              "price": 400,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item5",
              "price": 500,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item6",
              "price": 600,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item7",
              "price": 700,
              "image": "https://picsum.photos/200/300"
            }
          ]),
          Items(name: 'Shoes', items: [
            {
              "name": "item1",
              "price": 100,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item2",
              "price": 200,
              "image": "https://picsum.photos/200/300"
            },
        
          ]),
          Items(name: 'Accessories', items: [
            {
              "name": "item1",
              "price": 100,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item2",
              "price": 200,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item3",
              "price": 300,
              "image": "https://picsum.photos/200/300"
            },
            {
              "name": "item4",
              "price": 400,
              "image": "https://picsum.photos/200/300"
            },
      
          ])
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.shirt),
            label: '',
          ),
          // item with circle avatar with profile picture url from args , if empty add letters of name
          BottomNavigationBarItem(
            icon: profilepicture.isNotEmpty
                ? CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(profilepicture),
                  )
                : CircleAvatar(
                    radius: 15,
                    backgroundColor:
                        Colors.blue, // Set a background color of your choice
                    child: Text(
                      username.isNotEmpty ? username[0].toUpperCase() : '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
