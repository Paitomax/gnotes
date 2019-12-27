import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/note.dart';

@immutable
abstract class NoteListWidgetState extends Equatable {}

class NoteListWidgetLoadingState extends NoteListWidgetState {
  @override
  List<Object> get props => [];
}

class NoteListWidgetLoadedState extends NoteListWidgetState {
  final List<Note> notes;

  NoteListWidgetLoadedState(this.notes);

  @override
  List<Object> get props => [notes];
}

class ErrorNoteListWidgetState extends NoteListWidgetState {
  final String error;

  ErrorNoteListWidgetState(this.error);

  @override
  List<Object> get props => [error];
}

class NoteListWidgetSelectionChangedState extends NoteListWidgetState {
  final List<Note> notes;
  final List<String> listNoteIdSelection;
  final int selectionCount;

  NoteListWidgetSelectionChangedState(this.notes,
      this.listNoteIdSelection, this.selectionCount);

  @override
  List<Object> get props => [notes,listNoteIdSelection, selectionCount];
}
