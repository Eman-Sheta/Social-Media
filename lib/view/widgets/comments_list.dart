import 'package:flutter/material.dart';
import 'package:social_media/model/comment_model.dart';
import 'package:social_media/view/widgets/inherited_widgets/inherited_post_model.dart';
import 'package:social_media/view/widgets/user_details_with_follow.dart';

class CommentsListKeyPrefix {
  static const String singleComment = "Comment";
  static const String commentUser = "Comment User";
  static const String commentText = "Comment Text";
  static const String commentDivider = "Comment Divider";
}

class CommentsList extends StatelessWidget {
  const CommentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CommentModel> comments =
        InheritedPostModel.of(context).postData.comments;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ExpansionTile(
        leading: const Icon(Icons.comment),
        trailing: Text(comments.length.toString()),
        title: const Text("Comments"),
        children: List<Widget>.generate(
          comments.length,
          (int index) => _SingleComment(
            key: ValueKey("${CommentsListKeyPrefix.singleComment} $index"),
            index: index,
          ),
        ),
      ),
    );
  }
}

class _SingleComment extends StatelessWidget {
  final int index;

  const _SingleComment({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CommentModel commentData =
        InheritedPostModel.of(context).postData.comments[index];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserDetailsWithFollow(
            key: ValueKey("${CommentsListKeyPrefix.commentUser} $index"),
            userData: commentData.user,
          ),
          Text(
            commentData.comment,
            key: ValueKey("${CommentsListKeyPrefix.commentText} $index"),
            textAlign: TextAlign.left,
          ),
          Divider(
            key: ValueKey("${CommentsListKeyPrefix.commentDivider} $index"),
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
