import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Widget tagBuild(String tag, Color color) {
  return GestureDetector(
    onTap: () {
      Toast.show("This feature will be available soon!",
          duration: Toast.lengthShort, gravity: Toast.bottom);
    },
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: color,
      shadowColor: color,
      elevation: 20.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Text(
          tag,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
