import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnotes/src/add_note/add_note_form.dart';
import 'package:gnotes/src/models/note.dart';

class AddNoteScreen extends StatelessWidget {
  final Note note;

  const AddNoteScreen({Key key, this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("GNotes"),
    ),
    body: AddNoteForm(),);
  }
}
