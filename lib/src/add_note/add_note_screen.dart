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
  bool _newNote;
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _bodyFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _newNote = widget.note == null;

    if (!_newNote) {
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
          title: Text(_newNote ? "Nova Nota" : "Editar Nota"),
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
        body: BlocListener(
          bloc: _bloc,
          listener: (context, state) {
            if (state is AddNoteLoaded) {
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<AddNoteBloc, AddNoteState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is AddNoteError) {
                  return Center(child: Text(state.error));
                } else if (state is AddNoteLoading) {
                  return CircularProgressIndicator();
                } else {
                  return Form(
                    child: Column(
                      children: <Widget>[
                        _getTitle(),
                        _getBody(),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
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

  Widget _getBody() {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
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
        _titleController.text.trim().isEmpty && _bodyController.text.trim().isEmpty;

    if (textEmpty && _newNote ||
        !_newNote &&
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

    if (!textEmpty)
      _bloc.add(AddNote(note));
    else
      _bloc.add(DeleteNote(note));
  }
}
