import 'package:equatable/equatable.dart';
import 'package:gnotes/src/models/note.dart';

abstract class NoteEvent extends Equatable {}

class AddNote extends NoteEvent {
  final Note note;

  AddNote(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NoteEvent {
  final Note note;

  DeleteNote(this.note);

  @override
  List<Object> get props => [note];
}
