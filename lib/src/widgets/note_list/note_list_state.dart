import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'models/note_model.dart';

@immutable
abstract class NoteListWidgetState extends Equatable {}

class NoteListWidgetLoadingState extends NoteListWidgetState {
  @override
  String toString() => 'LoadTodos';

  @override
  List<Object> get props => null;
}

class NoteListWidgetLoadedState extends NoteListWidgetState {
  final List<NoteModel> notes;

  NoteListWidgetLoadedState(this.notes);

  @override
  List<Object> get props => [notes];
}
