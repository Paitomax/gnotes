import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnotes/src/add_note/add_note_form.dart';

class AddNoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("GNotes"),
    ),
    body: AddNoteForm(),);
  }
}
