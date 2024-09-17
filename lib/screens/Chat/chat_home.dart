import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unipp/screens/Chat/user_stream_chat.dart';
import 'calls_chat.dart';
import 'new_message_chat.dart';

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
                  builder: (context) => const CallsChat(),
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
                  builder: (context) => const NewMessageChat(),
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
        child: UserStream(),
      ),
    );
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
