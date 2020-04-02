import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testnorthapp/home.dart';

void main() {

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      home: Home(),
      builder: (context, child) {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: child,
      );}
    )
  );

  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

