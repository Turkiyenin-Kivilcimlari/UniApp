import 'package:flutter/material.dart';

class MyVerificationButton extends StatelessWidget {
  final String text;

  final void Function()? onpressed;

  MyVerificationButton({Key? key, required this.text, required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.065,
        width: MediaQuery.of(context).size.width * 0.577,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 165, 0, 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
