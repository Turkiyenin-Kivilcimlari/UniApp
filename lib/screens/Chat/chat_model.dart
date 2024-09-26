import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:image_picker/image_picker.dart';

import 'message_bubble.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
bool isOpen = false;
User? loggedInUser = _auth.currentUser;

// const kSendButtonTextStyle = TextStyle(
//   color: Colors.lightBlueAccent,
//   fontWeight: FontWeight.bold,
//   fontSize: 18.0,
// );

bool isAllEmoji(String text) {
  for (String s in EmojiParser().unemojify(text).split(" ")) {
    if (!s.startsWith(":") || !s.endsWith(":")) return false;
  }
  return true;
  return false;
}

InputDecoration kMessageTextFieldDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 20.0,
    ),
    prefixIcon: IconButton(
        onPressed: () {}, icon: const Icon(Icons.emoji_emotions_outlined)),
    suffixIcon:
        IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt)),
    hintText: 'Type a message',
    hintStyle: const TextStyle(
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

class PmScreen extends StatefulWidget {
  static const String id = 'chat_pm';
  final String selectedUser;
  final String profileUrl;
  final String name;

  const PmScreen(
      {Key? key,
      required this.selectedUser,
      required this.name,
      required this.profileUrl})
      : super(key: key);
  @override
  _PmScreenState createState() => _PmScreenState();
}

class _PmScreenState extends State<PmScreen> {
  final messageTextController = TextEditingController();

  //initialising firestore

  late String messageText;

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
    // return BlocListener<FileHandlerBloc, FileHandlerState>(
    //   listener: (context, state) {
    //     //var bloc = BlocProvider.of<FileHandlerBloc>(context);
    //     if (state is OptionsPopupOpened) {
    //       bloc.add(PickFile(state.type));
    //       //   }
    //     }
    //   },
    //  child:
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back),
          color: Colors.black,
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(widget.profileUrl),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Metropolis',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.videocam,
                color: Colors.black,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.phone,
                color: Colors.black,
              ),
            ),
            DropdownButton2(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              underline: Container(),
              customButton: Container(
                child: const Icon(
                  CupertinoIcons.list_bullet,
                  color: Colors.black,
                ),
              ),
              items: [
                const MenuItem(
                  value: 'Block',
                  text: '',
                  widget: Block(
                    key: Key('a'),
                  ),
                  key: Key('A'),
                ),
                const MenuItem(
                  value: 'Report',
                  text: '',
                  widget: Report(
                    key: Key('a'),
                  ),
                  key: Key('a'),
                ),
              ].map<DropdownMenuItem<MenuItem>>((MenuItem value) {
                return DropdownMenuItem<MenuItem>(
                  value: value,
                  child: value,
                );
              }).toList(),
              onMenuStateChange: (isOpen) {
                onMenuStateChange(isOpen);
              },
              onChanged: (MenuItem? item) {
                if (item == null) return;
                switch (item.value) {
                  case 'Block':
                    // Handle Block action
                    break;
                  case 'Report':
                    // Handle Report action
                    break;
                }
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(
              selectedUser: widget.selectedUser,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                // decoration: ,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: kMessageContainerDecoration,
                        child: TextField(
                          controller: messageTextController,
                          onChanged: (value) {
                            messageText = value;
                            //Do something with the user input.
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore
                            .collection('users')
                            .doc(widget.selectedUser)
                            .collection('messages')
                            .doc(loggedInUser?.uid)
                            .collection('pms')
                            .doc()
                            .set({
                          'text': messageText,
                          'sender': loggedInUser?.email,
                          'timestamp': FieldValue.serverTimestamp()
                        });
                        _firestore
                            .collection('users')
                            .doc(loggedInUser?.uid)
                            .collection('messages')
                            .doc(widget.selectedUser)
                            .collection('pms')
                            .doc()
                            .set({
                          'text': messageText,
                          'sender': loggedInUser?.email,
                          'timestamp': FieldValue.serverTimestamp()
                        });
                        // .add({
                        //   'text': messageText,
                        //   'sender': loggedInUser.email,
                        //   'timestamp': FieldValue.serverTimestamp()
                        // });
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
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }

  void onMenuStateChange(open) {
    setState(() {
      isOpen = open;
    });
  }
}

class MessageStream extends StatelessWidget {
  final selectedUser;

  const MessageStream({Key? key, @required this.selectedUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .doc(loggedInUser?.uid)
          .collection('messages')
          .doc(selectedUser)
          .collection('pms')
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final messages = snapshot.data?.docs.reversed;

        for (var message in messages!) {
          final messageText = message['text'];
          final messageSender = message['sender'];
          final currentUser = loggedInUser?.email;
          final messageBubble = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MenuItem extends StatefulWidget {
  final String value;
  final String text;
  final Widget widget;
  const MenuItem({
    required Key key,
    required this.value,
    required this.widget,
    required this.text,
  }) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return widget.widget ?? Container();
  }
}

class Block extends StatefulWidget {
  const Block({required Key key}) : super(key: key);

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Block',
    );
  }
}

class Report extends StatefulWidget {
  const Report({required Key key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Report',
    );
  }
}
