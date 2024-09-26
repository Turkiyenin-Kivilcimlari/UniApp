import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Profile photo - squircle --> posts no | Followers no | Following no |
//Name o <em>Position</em>
//About
final _auth = FirebaseAuth.instance;
final _store = FirebaseFirestore.instance;
late User currentUser;
Future data = _store.collection('users').doc(currentUser.uid).get();

class ProfileModel extends StatelessWidget {
  const ProfileModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  image: const DecorationImage(
                    image: NetworkImage(''),
                    fit: BoxFit.cover,
                  )),
            ),
            const Column(
              children: <Widget>[Text('21'), Text('Posts')],
            ),
            const FaIcon(
              FontAwesomeIcons.ellipsisV,
            ),
            const Column(
              children: <Widget>[Text('21'), Text('Followers')],
            ),
            const FaIcon(
              FontAwesomeIcons.ellipsisV,
            ),
            const Column(
              children: <Widget>[Text('21'), Text('Following')],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(currentUser.displayName!),
            const FaIcon(FontAwesomeIcons.circle),
            const Text('Flutter app developer'),
          ],
        ),
        Row(
          children: <Widget>[
            ElevatedButton(onPressed: () {}, child: const Text('Follow')),
            ElevatedButton(onPressed: () {}, child: const Text('Message'))
          ],
        ),
      ],
    );
  }
}
