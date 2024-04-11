import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'photo_detail_screen.dart';

class PhotoListScreen extends StatefulWidget {
  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  List<File> _images = [];

  void _addImage(File image) {
    setState(() {
      _images.add(image);
    });
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _navigateToDetailScreen(File image) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoDetailScreen(image)),
    );
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _addImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _takePhoto,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.file(_images[index]),
            title: Text('Photo ${index + 1}'),
            onTap: () {
              _navigateToDetailScreen(_images[index]);
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeImage(index);
              },
            ),
          );
        },
      ),
    );
  }
}
