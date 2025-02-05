import 'package:flutter/material.dart';
import 'package:unipp/screens/verification/widget/my_verification_button.dart.dart';
import 'package:unipp/screens/verification/widget/my_verification_text_field.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({Key? key}) : super(key: key);

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
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset('images/update_page.png')),
            Container(
              child: Column(
                children: [
                  Text(
                    "Enter New Passord",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Enter the password you want to update",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(130, 130, 130, 1)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0275,
                  ),
                  MyVerificationTextField(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0275,
                  ),
                  MyVerificationTextField(),
                ],
              ),
            ),
            MyVerificationButton(
              text: "Update",
              onpressed: () {
                //onaylama işlemi yapılcak
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
