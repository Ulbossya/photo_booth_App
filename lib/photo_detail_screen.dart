import 'dart:io';
import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  final File image;

  PhotoDetailScreen(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Detail'),
      ),
      body: Center(
        child: Image.file(image),
      ),
    );
  }
}
