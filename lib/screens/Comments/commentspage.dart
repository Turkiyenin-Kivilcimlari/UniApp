import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../nav.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
bool tapped = false;
// User loggedInUser;

const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    prefixIcon: Icon(Icons.emoji_emotions_outlined),
    suffixIcon: Icon(Icons.camera_alt),
    hintText: 'Type a message',
    hintStyle: TextStyle(
      height: 1.5,
    ),
    border: InputBorder.none);

const kMessageContainerDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black,
      blurRadius: 0.7,
    ),
  ],
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(32),
      bottomRight: Radius.circular(32),
      bottomLeft: Radius.circular(32)),
);

class CommentsPage extends StatefulWidget {
  static const String id = 'comment_screen';
  final postID;

  const CommentsPage({Key? key, @required this.postID}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final messageTextController = TextEditingController();

  //initialising firestore

  late String commentText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text(
          'Comments',
          style: TextStyle(
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(postID: widget.postID),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: kMessageContainerDecoration,
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          commentText = value;
                          //Do something with the user input.
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore
                        .collection('posts')
                        .doc(widget.postID)
                        .collection('comments')
                        .add({
                      'name': loggedInUser?.displayName,
                      'comment': commentText,
                      'profile': loggedInUser?.photoURL,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                    //Implement send functionality.
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 25,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommentBubble extends StatefulWidget {
  final String text;
  final String url;
  final String sender;

  const CommentBubble(
      {Key? key, required this.text, required this.sender, required this.url})
      : super(key: key);

  @override
  State<CommentBubble> createState() => _CommentBubbleState();
}

class _CommentBubbleState extends State<CommentBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(loggedInUser!.photoURL!),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.sender,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Metropolis'),
                    ),
                    Container(
                      constraints:
                          const BoxConstraints(minWidth: 0, maxWidth: 200),
                      child: Text(
                        widget.text ?? '',
                        style: const TextStyle(
                          // fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'Metropolis',
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(32)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Reply',
                    style: TextStyle(
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    tapped = !tapped;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: tapped == false
                          ? Colors.grey.withOpacity(0.3)
                          : Colors.red.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(32)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FaIcon(
                      tapped == false
                          ? FontAwesomeIcons.heart
                          : FontAwesomeIcons.solidHeart,
                      color: Colors.black,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  final postID;

  const MessageStream({Key? key, @required this.postID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('posts')
          .doc(postID)
          .collection('comments')
          .snapshots(),
      builder: (context, snapshot) {
        List<CommentBubble> messageBubbles = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final messages = snapshot.data?.docs.reversed;

        for (var message in messages!) {
          final messageText = message['comment'];
          final messageSender = message['name'];
          final profileUrl = message['profile'];
          final messageBubble = CommentBubble(
            url: profileUrl,
            text: messageText,
            // profile:profileUrl,
            sender: messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
