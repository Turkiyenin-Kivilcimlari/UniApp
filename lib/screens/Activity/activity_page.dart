import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

import '../../widgets/ctag.dart';

class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListTile _followList(String name, String place) {
      return ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
          radius: 28.0,
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
            content: tagBuild('Böyle bir kullanıcı bulunamadı.', Colors.blue, context),
            duration: Duration(milliseconds: 550),
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
                      gradient: LinearGradient(
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
                          height:5.0,
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
                margin: EdgeInsets.fromLTRB(8.0, 20.0, 10.0, 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 30.0,
                shadowColor: Colors.blue,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 10.0),
                  height: 101.0,
                  width: 162.0,
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
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.deepPurple,
                          Colors.blueAccent
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ],
        ),
        _followList('Harris', 'Enathu'),
        _followList('Rahul', 'India'),
        _followList('Mani', 'Los Angeles'),
        _followList('Rajpal', 'Newzealand'),
        _followList('Kim jung', 'Trivandrum'),
        _followList('Gregory', 'Adoor'),
        _followList('Rahul', 'New York'),
        _followList('Devis', 'Kerala'),
        _followList('Ram', 'Jammu'),
        _followList('Edwin', 'India'),
        _followList('Aswathy', 'Kovalam'),
        _followList('Pranav', 'Thiruvalla'),
        _followList('Aswin', 'Pala'),
        _followList('Devu', 'Chenganoor'),
        _followList('Prakash', 'MAnnady'),
        _followList('Athul', 'Korea'),
        _followList('Rajiv', 'Washington'),
        _followList('Mohanlal', 'AbuDhabi'),
        _followList('Sethupathi', 'Heaven'),
      ],
    );
  }
}
