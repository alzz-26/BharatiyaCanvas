import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class ModelPage extends StatefulWidget {
  const ModelPage({super.key});

  @override
  State<ModelPage> createState() => _ModelState();
}

class _ModelState extends State<ModelPage> {
  File? _image;
  String _result = "Upload an image to see the prediction.";
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  final String _apiUrl = "<YOUR_IP_ADDRESS/predict"; // Replace with your Flask server URL

  Future<void> _pickCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = "Processing...";
      });

      await _uploadImage();
    }
  }

  Future<void> _pickGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = "Processing...";
      });

      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final request = http.MultipartRequest('POST', Uri.parse(_apiUrl));
      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);

        setState(() {
          _result = data;
        });
      } else {
        setState(() {
          _result = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _result = "Error: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 250,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                suffixIcon: const Icon(Icons.search)
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute<ProfileScreen>(builder: (context) => ProfileScreen(actions: [SignedOutAction((context) {Navigator.of(context).pop();})],),),);},
              icon: const Icon(Icons.person), iconSize: 40, color: Colors.redAccent),
          const Padding(
            padding: EdgeInsets.only(right:10.0),
            child: IconButton(onPressed: null, icon: Icon(Icons.favorite_rounded)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Art Predict', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),),
            const SizedBox(height: 20,),
            if (_image != null)
              Image.file(
                _image!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            else
              Container(
                height: 200,
                width: 200,
                color: Colors.grey[200],
                child: const Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickCamera,
              child: const Text("Take a Picture"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickGallery,
              child: const Text("Upload from Gallery"),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(
              _result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
