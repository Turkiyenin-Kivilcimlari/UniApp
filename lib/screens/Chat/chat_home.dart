import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'calls_chat.dart';
import 'chat_model.dart';
import 'new_message_chat.dart';


final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? _loggedInUser = _auth.currentUser;
List<String> docList = [];
void docCheck() async {
  var result = await _firestore
      .collection('users')
      .doc(_loggedInUser?.uid)
      .collection('messages')
      .get();
  for (var res in result.docs) {
    docList.add(res.id.toString());
  }
}

class ChatHome extends StatefulWidget {
  static const String id = 'chat_home';

  const ChatHome({Key? key}) : super(key: key);

  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _loggedInUser = user;
        if (kDebugMode) {
          print(_loggedInUser);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back),
          color: Colors.black,
        ),
        elevation: 0,
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallsChat(),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.video_camera,
              size: 40,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewMessageChat(),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.paperplane,
              size: 28,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
        ],
        backgroundColor: Colors.white,
      ),
      body: const SafeArea(
        child: UsersStream(),
      ),
    );
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
          final data = user.data() as Map<String, dynamic>?;

          if (data != null) {
            final profile = data['profile'] ?? '';
            final name = data['name'] ?? '';
            final selectedUid = data['userid'] ?? '';
            final currentUser = _loggedInUser?.displayName ?? '';

            final userBubble = UserBubble(
              profileUrl: profile,
              selectedUser: selectedUid,
              name: name,
              isMe: currentUser == name,
              message: '',
              time: '',
            );
            userBubbles.add(userBubble);
          }
        }
        return Expanded(
          child: ListView(
            children: userBubbles,
          ),
        );
      },
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
  final String time;
  final String message;
  final String selectedUser;
  final bool isMe;
  const UserBubble(
      {Key? key, required this.profileUrl,
      required this.name,
      required this.message,
      required this.time,
      required this.isMe,
      required this.selectedUser}) : super(key: key);

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
                  builder: (context) => PmScreen(
                    profileUrl: widget.profileUrl,
                    name: widget.name,
                    selectedUser: widget.selectedUser,
                  ),
                ),
              );
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
                              child: Text(
                                'Tap to start messaging..',
                                style: TextStyle(
                                    fontSize: 10, fontFamily: 'Metropolis'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FaIcon(FontAwesomeIcons.comment),
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



// class SendersStream extends StatelessWidget {
//   final List docNames;

//   SendersStream({this.docNames});
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream:  _firestore
//           .collection('users')
//           .doc(loggedInUser.uid)
//           .collection('messages')
//           .doc(selectedUser)
//           .collection('pms')
//           .orderBy('timestamp')
//           .snapshots(),
//       builder: (context, snapshot) {
//         List<UserBubble> senderBubbles = [];
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.lightBlue,
//             ),
//           );
//         }
//         final users = snapshot.data.docs;

//         for (var user in users) {
//           final profile = user['profile'];
//           final name = user['name'];
//           final selectedUid = user['userid'];
//           final currentUser = _loggedInUser.displayName;
//           final userBubble = UserBubble(
//             profileUrl: profile,
//             selectedUser: selectedUid,
//             name: name,
//             isMe: currentUser == name,
//           );
//           senderBubbles.add(userBubble);
//         }
//         return Expanded(
//           child: ListView(
//             children: senderBubbles,
//           ),
//         );
//       },
//     );
//   }
// }
