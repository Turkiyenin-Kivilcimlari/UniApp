import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unipp/screens/Chat/user_stream_chat.dart';
import "calls_model.dart";




class CallsChat extends StatefulWidget {
  static const String id = 'calls_chat';

  const CallsChat({Key? key}) : super(key: key);
  @override
  _CallsChatState createState() => _CallsChatState();
}

class _CallsChatState extends State<CallsChat> {
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
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,
        ),
        elevation: 0,
        title: const Text(
          'Calls',
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
            CallsModel(
              icon: CupertinoIcons.phone,
              type: 'Audio',
              typeDescription: 'Start with audio'
            ),
            CallsModel(
              icon: CupertinoIcons.video_camera,
              type: 'Video',
              typeDescription: 'Hang out on video'
            ),
          ],
        ),
      ),
    );
  }
}

