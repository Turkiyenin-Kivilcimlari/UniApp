import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'login_screen.dart';

class Welcome extends StatefulWidget {
  static const String id = 'welcome';

  const Welcome({Key? key}) : super(key: key);
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Hero(
                tag: 'logo',
                child: Text('Nallagram',
                    style: TextStyle(
                      fontFamily: 'Billabong',
                      color: Colors.black,
                      fontSize: 70.0,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 20.0),
                    child: Container(
                      // padding: EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 10.0),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.deepPurple,
                              Colors.blueAccent
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          borderRadius: BorderRadius.circular(20.0)),
                      // padding: EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 10.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider(
                          thickness: 2.0,
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'OR',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 2.0,
                        ))
                      ],
                    ),
                  ),
                  MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Register.id);
                      },
                      child: const Text('Sign up with Email')),
                  const SizedBox(
                    height: 80.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
