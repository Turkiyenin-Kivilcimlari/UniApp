import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Firebase Auth import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unipp/screens/Authenticate/welcome_screen.dart';

import '../Authenticate/register_screen.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.userPlus),
            title: Text("Follow and Invite Friends  "),
          ),
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.bell),
            title: Text("Notifications"),
          ),
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.lock),
            title: Text("Privacy"),
          ),
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.shieldAlt),
            title: Text("Security"),
          ),
          const ListTile(
              leading: FaIcon(FontAwesomeIcons.user), title: Text("Account")),
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.questionCircle),
            title: Text("Help"),
          ),
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.exclamationCircle),
            title: Text("About"),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.signOutAlt),
            title: const Text("Logout"),
            onTap: () async {
              // Firebase Auth sign out
              await FirebaseAuth.instance.signOut();
              // Ana sayfaya yönlendirme
              Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Welcome()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
