import 'package:flutter/material.dart';
import 'package:social_media/helper/demo_values.dart';
import 'package:social_media/model/post_model.dart';

class AddNewPost extends StatefulWidget {
  const AddNewPost({super.key});

  @override
  _AddNewPostState createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final String _imageURL = 'assets/images/leaf.jpg';

  Future<void> _addPost() async {
    if (_formKey.currentState!.validate()) {
      PostModel newPost = PostModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        summary: _summaryController.text,
        body: _bodyController.text,
        imageURL: _imageURL,
        postTime: DateTime.now(),
        reacts: 0,
        views: 0,
        author: DemoValues.users[0],
        comments: [],
      );

      await newPost.addNewPostToDatabase();
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post added successfully!')),
      );

      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(),
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _summaryController,
                decoration: InputDecoration(labelText: 'Summary'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a summary';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _bodyController,
                decoration: InputDecoration(labelText: 'Body'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter body text';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: _addPost,
                child: Text(
                  'Add Post',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
