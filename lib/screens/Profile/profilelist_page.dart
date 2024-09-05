import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unipp/screens/Profile/user_profile.dart';
import 'package:url_launcher/url_launcher.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

final currentUsermail = _auth.currentUser?.email;

class ProfileList extends StatelessWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.black,
              )),
        ),
        body: const UsersStream(),
      ),
    );
  }
}

Future<bool> validateImageUrl(String url) async {
  try {
    final Uri uri = Uri.parse(url);
    return await canLaunchUrl(uri);
  } catch (e) {
    return false;
  }
}

class UserBubble extends StatefulWidget {
  final String profileUrl;
  final String name;
  final int posts;
  final int followers;
  final int following;
  final String descr;
  final String selectedUser;
  final bool isMe;

  const UserBubble(
      {Key? key,
      required this.profileUrl,
      required this.descr,
      required this.posts,
      required this.followers,
      required this.following,
      required this.name,
      required this.isMe,
      required this.selectedUser})
      : super(key: key);

  @override
  State<UserBubble> createState() => _UserBubbleState();
}

class _UserBubbleState extends State<UserBubble> {
  bool _isValidUrl = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkImageUrl();
  }

  void _checkImageUrl() async {
    bool isValid = await validateImageUrl(widget.profileUrl);
    setState(() {
      _isValidUrl = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isMe) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MaterialApp(
                          home: Scaffold(
                              appBar: AppBar(
                                backgroundColor: Colors.white,
                                leading: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    CupertinoIcons.back,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              body: UserProfile(
                                  followers: widget.followers,
                                  following: widget.following,
                                  posts: widget.posts,
                                  photoUrl: widget.profileUrl,
                                  descr: widget.descr,
                                  name: widget.name,
                                  userid: widget.selectedUser)))));
            });
          },
          child: Container(
            height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 32,
                        backgroundImage: _isValidUrl
                            ? CachedNetworkImageProvider(widget.profileUrl)
                            : AssetImage('assets/images/default_avatar.png')
                                as ImageProvider,
                        // Yedek resim
                        child: _isValidUrl
                            ? null
                            : Icon(Icons.person,
                                size: 32, color: Colors.white), // Yedek ikon
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Metropolis'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text('Tap to view profile',
                                  style: TextStyle(
                                      fontSize: 10, fontFamily: 'Metropolis')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class UsersStream extends StatelessWidget {
  const UsersStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        List<UserBubble> userBubbles = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final users = snapshot.data?.docs;

        for (var user in users!) {
          final profile =
              user.data().toString().contains('profile') ? user['profile'] : '';
          final name =
              user.data().toString().contains('name') ? user['name'] : '';
          final followers = user.data().toString().contains('followers')
              ? user['followers']
              : 0;
          final following = user.data().toString().contains('following')
              ? user['following']
              : 0;
          final descr =
              user.data().toString().contains('descr') ? user['descr'] : '';
          final posts =
              user.data().toString().contains('posts') ? user['posts'] : 0;
          final selectedUid =
              user.data().toString().contains('userid') ? user['userid'] : '';
          final currentUser = _auth.currentUser?.displayName;
          final userBubble = UserBubble(
            descr: descr,
            followers: followers,
            following: following,
            posts: posts,
            profileUrl: profile,
            selectedUser: selectedUid,
            name: name,
            isMe: currentUser == name,
          );
          userBubbles.add(userBubble);
        }
        return ListView(
          children: userBubbles,
        );
      },
    );
  }
}
