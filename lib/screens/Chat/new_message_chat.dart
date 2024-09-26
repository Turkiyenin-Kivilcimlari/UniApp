import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:unipp/screens/Chat/user_stream_chat.dart';

import '../../widgets/SearchBox.dart';

class NewMessageChat extends StatefulWidget {
  static const String id = 'new_message_chat';

  const NewMessageChat({Key? key}) : super(key: key);

  @override
  _NewMessageChatState createState() => _NewMessageChatState();
}

class _NewMessageChatState extends State<NewMessageChat> {
  //initialising firestore

  late String messageText;

  @override
  void initState() {
    super.initState();
    // docCheck();
    getCurrentUser();
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
          'New message',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'To',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  fontFamily: 'Metropolis',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: SearchBox(
                key: Key('a'),
              ),
            ),
            UserStream(),
          ],
        ),
      ),
    );
  }
}
