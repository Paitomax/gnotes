import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/note.dart';

@immutable
abstract class NoteListWidgetState extends Equatable {}

class NoteListWidgetLoadingState extends NoteListWidgetState {
  @override
  String toString() => 'LoadTodos';

  @override
  List<Object> get props => [];
}

class NoteListWidgetSelectionChangedState extends NoteListWidgetState {
  final List<String> listNoteIdSelection;
  final int selectionCount;

  NoteListWidgetSelectionChangedState(
      this.listNoteIdSelection, this.selectionCount);

  @override
  List<Object> get props => [listNoteIdSelection, selectionCount];
}
