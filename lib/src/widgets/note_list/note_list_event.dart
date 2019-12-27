import 'package:equatable/equatable.dart';

abstract class NoteListWidgetEvent extends Equatable {}

class NoteListWidgetSelectionChangedEvent extends NoteListWidgetEvent {
  final String id;

  NoteListWidgetSelectionChangedEvent(this.id);

  @override
  List<Object> get props => [id];
}

class NoteListWidgetClearSelectionEvent extends NoteListWidgetEvent {
  NoteListWidgetClearSelectionEvent();

  @override
  List<Object> get props => [];
}

class DeleteSelectedNotesEvent extends NoteListWidgetEvent {
  @override
  List<Object> get props => [];
}
