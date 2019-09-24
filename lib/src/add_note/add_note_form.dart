import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnotes/src/add_note/add_note_bloc.dart';
import 'package:gnotes/src/add_note/add_note_event.dart';
import 'package:gnotes/src/add_note/add_note_state.dart';

class AddNoteForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddNoteFormState();
  }
}

class _AddNoteFormState extends State<AddNoteForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNoteBloc, AddNoteState>(builder: (context, data) {
      return Form(
        child: Column(
          children: <Widget>[
            getTitle(),
            getBody(),
          ],
        ),
      );
    });
  }

  getTitle() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: TextFormField(
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: "Titulo"),
      ),
    );
  }

  getBody() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: "Descricao"),
      ),
    );
  }
}
