import 'package:intl/intl.dart';
import 'package:social_media/Database/sqldb.dart';
import 'package:social_media/model/comment_model.dart';
import 'package:social_media/model/user_model.dart';

class PostModel {
  final String id, title, summary, body, imageURL;
  final DateTime postTime;
  int reacts, views;
  final UserModel author;
  final List<CommentModel> comments;

  PostModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.body,
    required this.imageURL,
    required this.postTime,
    required this.reacts,
    required this.views,
    required this.author,
    required this.comments,
  });

  String get postTimeFormatted => DateFormat.yMMMMEEEEd().format(postTime);

  Future<void> loadFromDatabase() async {
    final dbData = await SqlDb.instance.query(id);
    if (dbData != null) {
      reacts = dbData['reacts'];
      views = dbData['views'];
    }
  }

  Future<void> updateInDatabase() async {
    await SqlDb.instance.update({
      'id': id,
      'reacts': reacts,
      'views': views,
    });
  }

  Future<void> addNewPostToDatabase() async {
    await SqlDb.instance.insertPost(this);
  }
}
