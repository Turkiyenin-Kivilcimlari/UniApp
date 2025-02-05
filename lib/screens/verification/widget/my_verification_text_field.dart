import 'package:flutter/material.dart';

class MyVerificationTextField extends StatelessWidget {
  const MyVerificationTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.11, 0,
          MediaQuery.of(context).size.width * 0.11, 0),
      child: SizedBox(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
