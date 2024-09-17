import 'package:flutter/material.dart';

import '../screens/Profile/profilelist_page.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileList()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(255, 247, 242, 242),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Metropolis',
                  fontSize: 15.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
