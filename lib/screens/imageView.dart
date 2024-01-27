import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String url;
  ImageView(this.url);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final secondaryColor = Color(0xFFF25A9FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
                elevation: 4, // Add elevation to the AppBar
        iconTheme: IconThemeData(color: Colors.black), // Set icon color
        brightness: Brightness.light, // Set brightness to light
      ),
      body: Container(
        color: Colors.white,
        child: GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Hero(
              tag: 'imageHero',
              child: CachedNetworkImage(imageUrl: widget.url),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}