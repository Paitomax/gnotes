import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnotes/src/add_note/add_note_bloc.dart';
import 'package:gnotes/src/add_note/add_note_event.dart';
import 'package:gnotes/src/add_note/add_note_state.dart';
import 'package:gnotes/src/widgets/note_list/models/note_model.dart';

class AddNoteForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddNoteFormState();
  }
}

class _AddNoteFormState extends State<AddNoteForm> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  AddNoteBloc _bloc = AddNoteBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNoteBloc, AddNoteState>(
        bloc: _bloc,
        builder: (context, data) {
          return Form(
            child: Column(
              children: <Widget>[
                getTitle(),
                getBody(),
                getSubmitButton(),
              ],
            ),
          );
        });
  }

  getTitle() {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextFormField(
        controller: _titleController,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: "Titulo"),
      ),
    );
  }

  getBody() {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextFormField(
        controller: _bodyController,
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: "Descricao"),
      ),
    );
  }

  getSubmitButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: RaisedButton(
        child: Text(
          "Salvar",
        ),
        onPressed: () {
          NoteModel note =
              NoteModel(_titleController.text, _bodyController.text);
          _bloc.dispatch(AddNoteSubmit(note));
        },
      ),
    );
  }
}
