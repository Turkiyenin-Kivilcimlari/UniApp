import 'package:flutter/material.dart';
import '../../models/story_view_model.dart';
import '../../widgets/post_card.dart';
import '../../widgets/story_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = FirebaseFirestore.instance;

List<String> likedusers = [];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SizedBox spacing() {
    return SizedBox(
      width: 15.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      spacing(),
                      StoryWid(
                          img: StoryViewData[0].img,
                          name: StoryViewData[0].name, key:Key('0')),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[1].img,
                          name: StoryViewData[1].name, key:Key('1')),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[2].img,
                          name: StoryViewData[2].name, key:Key('2')),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[3].img,
                          name: StoryViewData[3].name, key:Key('3')),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[4].img,
                          name: StoryViewData[4].name, key:Key('4')),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[5].img,
                          name: StoryViewData[5].name, key:Key('5')),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[6].img,
                          name: StoryViewData[6].name, key:Key('6')),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[7].img,
                          name: StoryViewData[7].name, key:Key('7')),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[8].img,
                          name: StoryViewData[8].name, key:Key('8')),
                      spacing(),
                      StoryWid(
                          img: StoryViewData[9].img,
                          name: StoryViewData[9].name, key:Key('9')),
                      spacing(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          PostStream(),
        ],
      ),
    ]);
  }
}

class PostStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('posts').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        List<PostCard> postCards = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final posts = snapshot.data?.docs;

        for (var post in posts!) {
          // var likedusrs = await Likecheck(post.id);
          // var data = likedusrs.data();
          final likesCount = post['likes'];
          final name = post['name'];
          final place = post['place'];
          final profilePic = post['profilepicurl'];
          final postUrl = post['url'];
          final postId = post.id;
          final postCard = PostCard(
            likes: likesCount,
            // liked: ,
            name: name,
            place: place,
            profilePic: profilePic,
            postUrl: postUrl,
            postID: postId,
          );
          postCards.add(postCard);
        }
        return ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: postCards.reversed.toList(),
        );
      },
    );
  }
}
