import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/ctag.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListTile followList(String name, String place) {
      return ListTile(
        leading: const CircleAvatar(
          radius: 28.0,
          child: Icon(Icons.person),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        subtitle: Text(
          place,
          style: const TextStyle(
            fontFamily: 'Metropolis',
            fontSize: 12.0,
          ),
        ),
        trailing: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.userPlus,
            color: Colors.blueAccent,
            size: 19.0,
          ),
          onPressed: () {
            ////
          },
        ),
        onTap: () {
          final snackBar = SnackBar(
            content: tagBuild(
                'Böyle bir kullanıcı bulunamadı.', Colors.blue, context),
            duration: const Duration(milliseconds: 550),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      );
    }

    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Card(
                margin: const EdgeInsets.fromLTRB(10.0, 20.0, 3.0, 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 30.0,
                shadowColor: Colors.pink,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 50.0, 15.0),
                  height: 101.0,
                  width: 169.0,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.pink, Colors.redAccent, Colors.orange],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: ListView(children: const <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'New Followers',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Last 7 days',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Metropolis',
                              fontSize: 10.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '265',
                          style: TextStyle(
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            //Todo: Randomise Profile pics
            //Todo: Randomise Network images
            Expanded(
              child: Card(
                margin: const EdgeInsets.fromLTRB(8.0, 20.0, 10.0, 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 30.0,
                shadowColor: Colors.blue,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 10.0),
                  height: 101.0,
                  width: 162.0,
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
                  child: ListView(children: const <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Unfollowed',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Last 7 days',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Metropolis',
                              fontSize: 10.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '82',
                          style: TextStyle(
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
        followList('Harris', 'Enathu'),
        followList('Rahul', 'India'),
        followList('Mani', 'Los Angeles'),
        followList('Rajpal', 'Newzealand'),
        followList('Kim jung', 'Trivandrum'),
        followList('Gregory', 'Adoor'),
        followList('Rahul', 'New York'),
        followList('Devis', 'Kerala'),
        followList('Ram', 'Jammu'),
        followList('Edwin', 'India'),
        followList('Aswathy', 'Kovalam'),
        followList('Pranav', 'Thiruvalla'),
        followList('Aswin', 'Pala'),
        followList('Devu', 'Chenganoor'),
        followList('Prakash', 'MAnnady'),
        followList('Athul', 'Korea'),
        followList('Rajiv', 'Washington'),
        followList('Mohanlal', 'AbuDhabi'),
        followList('Sethupathi', 'Heaven'),
      ],
    );
  }
}
