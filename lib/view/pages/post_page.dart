import 'package:flutter/material.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/view/presentation/themes.dart';
import 'package:social_media/view/widgets/comments_list.dart';
import 'package:social_media/view/widgets/inherited_widgets/inherited_post_model.dart';
import 'package:social_media/view/widgets/post_stats.dart';
import 'package:social_media/view/widgets/post_time_stamp.dart';
import 'package:social_media/view/widgets/user_details_with_follow.dart';

class PostPageKeys {
  static const ValueKey wholePage = ValueKey("wholePage");
  static const ValueKey bannerImage = ValueKey("bannerImage");
  static const ValueKey summary = ValueKey("summary");
  static const ValueKey mainBody = ValueKey("mainBody");
}

class PostPage extends StatelessWidget {
  final PostModel postData;

  const PostPage({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(postData.title)),
      body: InheritedPostModel(
        postData: postData,
        child: ListView(
          key: PostPageKeys.wholePage,
          children: const <Widget>[
            _BannerImage(key: PostPageKeys.bannerImage),
            _NonImageContents(),
          ],
        ),
      ),
    );
  }
}

class _BannerImage extends StatelessWidget {
  const _BannerImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      InheritedPostModel.of(context).postData.imageURL,
      fit: BoxFit.fitWidth,
    );
  }
}

class _NonImageContents extends StatelessWidget {
  const _NonImageContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Summary(key: PostPageKeys.summary),
          const PostTimeStamp(),
          const _MainBody(key: PostPageKeys.mainBody),
          UserDetailsWithFollow(
            userData: postData.author,
          ),
          const SizedBox(height: 8.0),
          PostStats(),
          const CommentsList(),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        InheritedPostModel.of(context).postData.summary,
        style: MyTheme.title,
      ),
    );
  }
}

class _MainBody extends StatelessWidget {
  const _MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        InheritedPostModel.of(context).postData.body,
        style: MyTheme.body1,
      ),
    );
  }
}
