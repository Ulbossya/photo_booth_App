import 'package:flutter/material.dart';
import 'package:photo_booth_app/photo_list.scren.dart';

void main() {
  runApp(PhotoBoothApp());
}

class PhotoBoothApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Booth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoListScreen(), 
    );
  }
}
