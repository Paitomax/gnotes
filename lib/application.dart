import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GNoteApplication extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GNote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

}