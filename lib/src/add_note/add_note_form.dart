import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnotes/src/add_note/add_note_bloc.dart';
import 'package:gnotes/src/add_note/add_note_event.dart';
import 'package:gnotes/src/add_note/add_note_state.dart';
import 'package:gnotes/src/models/note.dart';

class AddNoteForm extends StatefulWidget {
  final Note note;

  const AddNoteForm({Key key, this.note}) : super(key: key);

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
    if (widget.note != null) {
      _titleController.text = widget.note.title;
      _bodyController.text = widget.note.body;
    }
    return BlocBuilder<AddNoteBloc, AddNoteState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is AddNoteError) {
            return Text(state.error);
          } else if (state is AddNoteLoading) {
            return CircularProgressIndicator();
          } else if (state is AddNoteLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            return CircularProgressIndicator();
          } else {
            return Form(
              child: Column(
                children: <Widget>[
                  getTitle(),
                  getBody(),
                  getSubmitButton(),
                ],
              ),
            );
          }
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
          DateTime dateTimeNow = DateTime.now();
          Note note = Note(
              _titleController.text,
              _bodyController.text,
              widget.note != null ? widget.note.createTime : dateTimeNow,
              dateTimeNow,
              id: widget.note != null ? widget.note.id : null);
          _bloc.dispatch(AddNoteSubmit(note));
        },
      ),
    );
  }
}
