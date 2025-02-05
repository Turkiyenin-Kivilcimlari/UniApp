import 'package:flutter/material.dart';
import 'package:unipp/screens/verification/verify_code.dart';
import 'package:unipp/screens/verification/widget/my_verification_button.dart.dart';

class SendCode extends StatelessWidget {
  SendCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text('Send Code')),
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
                child: Image.asset('images/send_code.png')),
            Container(
              child: Column(
                children: [
                  Text(
                    "Enter Your Email",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.11,
                        0,
                        MediaQuery.of(context).size.width * 0.11,
                        0),
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
                  ),
                  Text(
                    "to change your password",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(130, 130, 130, 1)),
                  ),
                ],
              ),
            ),
            MyVerificationButton(
              text: "Send Code",
              onpressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => VerifyCode()));
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
