import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unipp/screens/verification/update_page.dart';
import 'package:unipp/screens/verification/widget/my_verification_button.dart.dart';
import 'package:unipp/screens/verification/widget/pinput.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.639,
                height: MediaQuery.of(context).size.height * 0.26,
                child: Image.asset('images/otp_code.png')),
            Container(
              child: Column(
                children: [
                  Text(
                    "Enter OTP Code",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Enter the 6-digit code sent to your email",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(130, 130, 130, 1)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.11,
                        0,
                        MediaQuery.of(context).size.width * 0.11,
                        0),
                    child: SizedBox(
                      child: PinPut(),
                    ),
                  ),
                  Text(
                    "to change your password",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(130, 130, 130, 1)),
                  ),
                ],
              ),
            ),
            MyVerificationButton(
              text: "Verify",
              onpressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UpdatePage()));
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
