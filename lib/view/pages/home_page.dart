import 'package:flutter/material.dart';
import 'package:social_media/Database/sqldb.dart';
import 'package:social_media/helper/demo_values.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/view/pages/add_newpost.dart';
import 'package:social_media/view/widgets/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    List<Map<String, dynamic>> postMaps = await SqlDb.instance.queryAllPosts();
    setState(() {
      _posts = postMaps.map((map) {
        return PostModel(
          id: map['id'],
          reacts: map['reacts'],
          views: map['views'],
          title: map['title'],
          summary: map['summary'],
          body: map['body'],
          imageURL: map['imageURL'],
          postTime: DateTime.parse(map['postTime']),
          author:
              DemoValues.users.firstWhere((user) => user.id == map['authorId']),
          comments: [],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaf"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddNewPost()),
              ).then((_) {
                _fetchPosts();
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (BuildContext context, int index) {
          return PostCard(postData: _posts[index]);
        },
      ),
    );
  }
}
