import 'package:gnotes/src/models/note.dart';

abstract class AddNoteEvent {}

class AddNoteSubmit extends AddNoteEvent {
  Note note;
  AddNoteSubmit(note);
}
