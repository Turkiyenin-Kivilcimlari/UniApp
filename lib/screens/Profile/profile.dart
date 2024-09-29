import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../nav.dart';
import '../Posts/postView_model.dart';
import '../Story/storyview.dart';
import '../settings/settings.dart';
import 'edit_profile.dart';
import 'profile_upload.dart';

final _auth = FirebaseAuth.instance;
final _store = FirebaseFirestore.instance;
bool _persposts = true;
User? loggedInUser = auth.currentUser;

void getProfileData() async {
  final info = await _store.collection('users').doc(loggedInUser?.uid).get();
  Map<String, dynamic>? data = info.data();
  //if (data?['followers'] != null)
  followers = data?['followers'];
  //else
  //  followers = 0;
  //if (data?['following'] != null)
  //else
  //  followers = 0;
  following = data?['following'];
  descr = data?['descr'];
  posts = data?['posts'];
}

void getCurrentUser() {
  try {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  } catch (e) {
    print(e);
  }
}

late int? posts;
var descr;
late int? followers;
late int? following;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
                child: Container(
                    width: 80,
                    height: 80,
                    decoration: rimage != null
                        ? BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(25),
                          )
                        : BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  loggedInUser!.photoURL!),
                              fit: BoxFit.cover,
                            )),
                    child: rimage != null
                        ? Image.file(
                            rimage,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : Container()),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      '$posts',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Metropolis'),
                    ),
                  ),
                  const Text(
                    'Posts',
                    style: TextStyle(fontFamily: 'Metropolis', fontSize: 12),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: FaIcon(
                  FontAwesomeIcons.ellipsisV,
                  size: 10,
                  color: Colors.grey,
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      '$followers',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Metropolis'),
                    ),
                  ),
                  const Text(
                    'Followers',
                    style: TextStyle(fontFamily: 'Metropolis', fontSize: 12),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: FaIcon(
                  FontAwesomeIcons.ellipsisV,
                  size: 10,
                  color: Colors.grey,
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      '$following',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Metropolis'),
                    ),
                  ),
                  const Text(
                    'Following',
                    style: TextStyle(fontFamily: 'Metropolis', fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              loggedInUser!.displayName!.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Metropolis',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
              overflow: TextOverflow.clip,
              strutStyle: const StrutStyle(fontSize: 12.0),
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Metropolis'),
                  text: descr),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditPage()));
                    },
                    child: const Text(
                      'Edit profile',
                      style: TextStyle(color: Colors.black),
                    )),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: Container(
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppSettings(),
                          ));
                    },
                    child: const Text(
                      'Settings',
                      style: TextStyle(color: Colors.black),
                    )),
              )),
            ],
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Highlight(
                    name: 'Github',
                    url:
                        'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png'),
                Highlight(
                    name: 'LinkedIn',
                    url:
                        'https://cdn2.iconfinder.com/data/icons/simple-social-media-shadow/512/14-512.png'),
                Highlight(
                    name: 'Dribbble',
                    url:
                        'https://cdn.freebiesupply.com/logos/large/2x/dribbble-icon-1-logo-png-transparent.png'),
                Highlight(
                    name: 'Reddit',
                    url:
                        'https://www.redditinc.com/assets/images/site/reddit-logo.png'),
                Highlight(
                    name: 'Quora',
                    url:
                        'https://www.shareicon.net/data/128x128/2015/07/21/72869_quora_512x512.png'),
              ],
            ),
          ),
          const ProfilePosts(),
        ],
      ),
    );
  }
}

class Highlights extends StatefulWidget {
  final String name;
  final String url;

  const Highlights({Key? key, required this.name, required this.url})
      : super(key: key);

  @override
  _HighlightsState createState() => _HighlightsState();
}

class _HighlightsState extends State<Highlights> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(children: <Widget>[]),
    );
  }
}

class ProfilePosts extends StatefulWidget {
  const ProfilePosts({Key? key}) : super(key: key);

  @override
  _ProfilePostsState createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 500,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Material(
                    type: MaterialType
                        .transparency, //Makes it usable on any background color, thanks @IanSmith
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: _persposts ? Colors.black : Colors.grey,
                                width: 0.5)),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: InkWell(
                        //This keeps the splash effect within the circle
                        borderRadius: BorderRadius.circular(
                            1000), //Something large to ensure a circle
                        onTap: () {
                          setState(() {
                            _persposts = true;
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: FaIcon(
                              FontAwesomeIcons.thLarge,
                              color: _persposts ? Colors.black : Colors.grey,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              Expanded(
                child: Material(
                  type: MaterialType
                      .transparency, //Makes it usable on any background color, thanks @IanSmith
                  child: Ink(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: _persposts ? Colors.grey : Colors.black,
                                width: 0.5)),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: InkWell(
                        //This keeps the splash effect within the circle
                        borderRadius: BorderRadius.circular(
                            1000.0), //Something large to ensure a circle
                        onTap: () {
                          setState(() {
                            _persposts = false;
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: FaIcon(
                              FontAwesomeIcons.userTag,
                              size: 15,
                              color: _persposts ? Colors.grey : Colors.black,
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
          _persposts
              ? const ProfilePostsStream()
              : const Expanded(child: Tagged()),
        ],
      ),
    );
  }
}

class ImagePost extends StatelessWidget {
  final String url;
  final bool isMe = true;
  const ImagePost({Key? key, required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => POstView(url)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.red.shade100,
            image: DecorationImage(
              image: CachedNetworkImageProvider(url),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      // Return a default widget or another widget based on your needs
      return Container(); // Example of a default widget
    }
  }
}

class ProfilePostsStream extends StatelessWidget {
  const ProfilePostsStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store
          .collection('users')
          .doc(loggedInUser?.uid)
          .collection('posts')
          .snapshots(),
      builder: (context, snapshot) {
        List<ImagePost> ImagePosts = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final posts = snapshot.data?.docs.reversed;

        for (var post in posts!) {
          if (post['userid'] == loggedInUser?.uid) {
            final image = post['url'];
            final imagePost = ImagePost(
              url: image,
            );
            ImagePosts.add(imagePost);
          }
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: ImagePosts,
            ),
          ),
        );
      },
    );
  }
}

class Tagged extends StatelessWidget {
  const Tagged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        children: <Widget>[Text('No photos yet')],
      ),
    );
  }
}

class Highlight extends StatefulWidget {
  final String name;
  final String url;

  const Highlight({Key? key, required this.name, required this.url})
      : super(key: key);

  @override
  _HighlightState createState() => _HighlightState();
}

class _HighlightState extends State<Highlight> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(children: <Widget>[
          const SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StoryPageView(
                            key: Key('a'),
                          )));
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(widget.url), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            // padding: const EdgeInsets.fromLTRB(10.0, 5.0, 8.0, 5.0),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.name,
              style: const TextStyle(
                fontFamily: 'Metropolis',
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
