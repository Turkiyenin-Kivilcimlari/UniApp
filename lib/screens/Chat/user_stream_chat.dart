import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'chat_bubble.dart';



final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? _loggedInUser = _auth.currentUser;
List<String> docList = [];

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


class UserStream extends StatelessWidget {
  const UserStream({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }

        final users = snapshot.data?.docs;

        if (users == null || users.isEmpty) {
          return const Center(
            child: Text("No users available"),
          );
        }

        List<ChatBubble> chatBubbles = [];
        for (var user in users) {
          final data = user.data() as Map<String, dynamic>?;

          if (data != null && data['profile']!=null) {
            final profile = data['profile'];
            final name = data['name'] ?? 'isim Yok';
            final selectedUid = data['userid'] ?? '';
            final currentUser = _loggedInUser?.displayName ?? '';

            chatBubbles.add(
              ChatBubble(
                profileUrl: profile,
                selectedUser: selectedUid,
                name: name,
                isMe: currentUser == name,
                message: '',
                time: '',
              ),
            );
          }
        }

        return ListView.builder(
          itemCount: chatBubbles.length,
          itemBuilder: (context, index) {
            return chatBubbles[index];
          },

        );
      },
    );
  }
}