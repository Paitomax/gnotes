import 'package:equatable/equatable.dart';
import 'package:gnotes/src/models/note.dart';

abstract class AddNoteEvent extends Equatable {}

class AddNoteSubmit extends AddNoteEvent {
  final Note note;
  AddNoteSubmit(this.note);

  @override
  List<Object> get props => [note];
}
