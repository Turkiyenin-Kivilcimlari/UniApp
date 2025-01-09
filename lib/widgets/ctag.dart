import 'package:flutter/material.dart';

Widget tagBuild(String tag, Color color, BuildContext context) {
  return GestureDetector(
    onTap: () {
      final snackBar = SnackBar(
        content: tagBuild('Bu İçeriğe Ulaşılamıyor', Colors.red, context),
        duration: const Duration(milliseconds: 550),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
