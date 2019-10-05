import 'package:gnotes/src/widgets/note_list/models/note_model.dart';

abstract class AddNoteEvent {}

class AddNoteSubmit extends AddNoteEvent {
  NoteModel note;
  AddNoteSubmit(note);
}
