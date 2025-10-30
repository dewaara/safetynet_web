import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadInfo extends StatefulWidget {
  @override
  _UploadInfoState createState() => _UploadInfoState();
}

class _UploadInfoState extends State<UploadInfo> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  File? _imageFile;
  bool isLoading = false;

  // 📌 Pick an image from gallery
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  // 📌 Upload image to Firebase Storage
  Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child('post_images/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL(); // Return uploaded image URL
    } catch (e) {
      print("❌ Image Upload Error: $e");
      return "";
    }
  }

  // 📌 Upload data to Firestore
  Future<void> uploadData() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        linkController.text.isEmpty ||
        _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❗ Fill all fields & select an image")));
      return;
    }

    setState(() => isLoading = true);
    String imageUrl = await uploadImage(_imageFile!);

    if (imageUrl.isNotEmpty) {
      await FirebaseFirestore.instance.collection('posts').add({
        'title': titleController.text,
        'description': descriptionController.text,
        'date': Timestamp.now(),
        'imageUrl': imageUrl,
        'linkUrl': linkController.text,
      });

      // Clear Fields
      titleController.clear();
      descriptionController.clear();
      linkController.clear();
      setState(() {
        _imageFile = null;
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("✅ Post Added Successfully")));
    } else {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("❌ Image Upload Failed")));
    }
  }

  // 📌 Fetch Firestore data
  Stream<QuerySnapshot> getPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firestore Example")),
      body: Column(
        children: [
          // 📌 Form for Input
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: "Title")),
                TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: "Description")),
                TextField(
                    controller: linkController,
                    decoration: InputDecoration(labelText: "URL Link")),
                const SizedBox(height: 10),
                _imageFile != null
                    ? Image.file(_imageFile!,
                        height: 100, width: 100, fit: BoxFit.cover)
                    : ElevatedButton.icon(
                        onPressed: pickImage,
                        icon: Icon(Icons.image),
                        label: Text("Pick Image")),
                const SizedBox(height: 10),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: uploadData, child: Text("Upload Data")),
              ],
            ),
          ),

          // 📌 Display Firestore Data
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getPosts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var posts = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var data = posts[index].data() as Map<String, dynamic>;
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(data['imageUrl'],
                            width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(data['title']),
                        subtitle: Text(data['description']),
                        trailing: IconButton(
                          icon: Icon(Icons.link),
                          onPressed: () =>
                              launchUrl(Uri.parse(data['linkUrl'])),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
