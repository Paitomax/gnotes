import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnotes/src/home/home_screen.dart';

class GNoteApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GNote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
