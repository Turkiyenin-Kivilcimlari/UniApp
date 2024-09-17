import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class POstView extends StatefulWidget {
  final String url;
  const POstView(this.url, {Key? key}) : super(key: key);
  static const id = 'postview';
  @override
  _POstViewState createState() => _POstViewState();
}

class _POstViewState extends State<POstView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: PostCard(widget.url),
          ),
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final String postUrl;

  const PostCard(this.postUrl, {Key? key}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            shadowColor: Colors.black,
            elevation: 40.0,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(widget.postUrl),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      margin:
                          const EdgeInsets.fromLTRB(75.0, 310.0, 75.0, 30.0),
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 7),
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Center(
                        child: LikeButton(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 8.0),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.bookmark_border_rounded,
                              color: isLiked ? Colors.blueAccent : Colors.black,
                              size: 30.0,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
