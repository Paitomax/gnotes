import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gnotes/src/add_note/add_note_bloc.dart';
import 'package:gnotes/src/add_note/add_note_event.dart';
import 'package:gnotes/src/add_note/add_note_state.dart';
import 'package:gnotes/src/models/note.dart';

class AddNoteScreen extends StatefulWidget {
  final Note note;

  const AddNoteScreen({Key key, this.note}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  AddNoteBloc _bloc = AddNoteBloc();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _bodyFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note.title;
      _bodyController.text = widget.note.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _saveNoteAndExit();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("GNotes"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _saveNoteAndExit,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.save),
              onPressed: _saveNoteAndExit,
            )
          ],
        ),
        body: BlocBuilder<AddNoteBloc, AddNoteState>(
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
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }

  getTitle() {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextFormField(
        autofocus: true,
        focusNode: _titleFocus,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          _titleFocus.unfocus();
          FocusScope.of(context).requestFocus(_bodyFocus);
        },
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
        maxLength: 999,
        maxLines: 20,
        minLines: 1,
        focusNode: _bodyFocus,
        textInputAction: TextInputAction.newline,
        controller: _bodyController,
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: "Descricao"),
      ),
    );
  }

  _saveNoteAndExit() {
    var textEmpty =
        _titleController.text.isEmpty && _bodyController.text.isEmpty;
    var newNote = widget.note == null;

    if (textEmpty ||
        !newNote &&
            (_titleController.text == widget.note.title &&
                _bodyController.text == widget.note.body)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
      return;
    }

    DateTime dateTimeNow = DateTime.now();
    Note note = Note(_titleController.text, _bodyController.text,
        widget.note != null ? widget.note.createTime : dateTimeNow, dateTimeNow,
        id: widget.note != null ? widget.note.id : null);
    _bloc.dispatch(AddNoteSubmit(note));
  }
}
