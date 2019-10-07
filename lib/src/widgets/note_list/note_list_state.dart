import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/note.dart';

@immutable
abstract class NoteListWidgetState extends Equatable {}

class NoteListWidgetLoadingState extends NoteListWidgetState {
  @override
  String toString() => 'LoadTodos';

  @override
  List<Object> get props => null;
}

class NoteListWidgetLoadedState extends NoteListWidgetState {
  final List<Note> notes;

  NoteListWidgetLoadedState(this.notes);

  @override
  List<Object> get props => [notes];
}
