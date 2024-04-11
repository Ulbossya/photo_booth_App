import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_booth_app/main.dart';
import 'package:photo_booth_app/photo_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(PhotoBoothApp());
}


class PhotoListScreen extends StatefulWidget {
  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> imagePaths = prefs.getStringList('imagePaths') ?? [];
    setState(() {
      _images = imagePaths.map((path) => File(path)).toList();
    });
  }

  Future<void> _saveImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> imagePaths = _images.map((image) => image.path).toList();
    await prefs.setStringList('imagePaths', imagePaths);
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
        _saveImages();
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      _saveImages();
    });
  }

  void _navigateToDetailScreen(File image) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoDetailScreen(image)),
    );
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


