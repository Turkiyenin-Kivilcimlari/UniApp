import 'package:flutter/material.dart';
import '../../nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login_screen.dart';

class Register extends StatefulWidget {
  static const String id = 'register';

  const Register({Key? key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  bool showSpinner = false;
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  late String email;
  late String password;
  late String name;
  late String confirmPassword;

  List<String> profiles = [
    'https://cdn.dribbble.com/users/86682/screenshots/10441196/penguin.png',
    'https://cdn.dribbble.com/users/1162077/screenshots/7475318/media/8837a0ae1265548e27a2b2bb3ab1f366.png',
    'https://cdn.dribbble.com/users/1162077/screenshots/7495197/media/92507bdcf4b5edfa12d5e9cc4f01b301.png',
    'https://cdn.dribbble.com/users/1162077/screenshots/7542499/media/d6f3265e5017257e5900b762754f2655.png',
    'https://cdn.dribbble.com/users/1162077/screenshots/5940704/media/6a37a16dc390eed6c93f6f5020af211a.png'
  ];

  String photoUrl(List<String> pfls) {
    return pfls.elementAt(Random().nextInt(pfls.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFADD8E6),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 50),
                // Logo Image Comment
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/univercity_logo.png',
                    height: 80,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'univercity',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) => name = value,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        obscureText: _obscureText,
                        onChanged: (value) => password = value,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        obscureText: _obscureConfirmText,
                        onChanged: (value) => confirmPassword = value,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmText ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmText = !_obscureConfirmText;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          if (password != confirmPassword) {
                            // Show error message
                            return;
                          }
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser = await _auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            User? user = newUser.user;
                            user?.updateDisplayName(name);
                            var pfp = photoUrl(profiles);
                            user?.updatePhotoURL(pfp);
                            _store.collection('users').doc(user?.uid).set({
                              'name': name,
                              'profile': pfp,
                              'followerlist': [""],
                              'followinglist': [""],
                              'descr': 'Tap edit profile to update profile photo and description',
                              'followers': 0,
                              'userid': user?.uid,
                              'following': 0,
                              'posts': 0
                            });
                            Navigator.pushNamed(context, Nav.id);
                          } catch (e) {
                            print(e);
                          } finally {
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(fontSize: 16,color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'or continue with',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.google),
                            onPressed: () {
                              // Implement Google sign in
                            },
                          ),
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.facebook),
                            onPressed: () {
                              // Implement Facebook sign in
                            },
                          ),
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.apple),
                            onPressed: () {
                              // Implement Apple sign in
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
