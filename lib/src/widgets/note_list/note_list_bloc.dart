import 'package:bloc/bloc.dart';
import 'package:gnotes/src/auth_manager.dart';
import 'package:gnotes/src/models/note.dart';
import 'package:gnotes/src/store_provider.dart';
import 'package:gnotes/src/widgets/note_list/note_list_state.dart';

import 'note_list_event.dart';

class NoteListWidgetBloc
    extends Bloc<NoteListWidgetEvent, NoteListWidgetState> {
  List<String> _listNoteIdSelection = [];
  List<Note> _listNote;

  @override
  NoteListWidgetState get initialState => NoteListWidgetLoadingState();

  @override
  Stream<NoteListWidgetState> mapEventToState(
      NoteListWidgetEvent event) async* {
    if (event is NoteListWidgetFetchNotesEvent) {
      yield* _mapToNoteListWidgetFetchNotesEvent();
    } else if (event is NoteListWidgetSelectionChangedEvent) {
      yield* _mapNoteListWidgetSelectionChangedEvent(event.id);
    } else if (event is NoteListWidgetClearSelectionEvent) {
      yield* _mapNoteListWidgetClearSelectionEvent();
    } else if (event is DeleteSelectedNotesEvent) {
      yield* _mapDeleteSelectedNotesEvent();
    }
  }

  Stream<NoteListWidgetState> _mapToNoteListWidgetFetchNotesEvent() async* {
    try {
      yield NoteListWidgetLoadingState();
      var notes = await StoreProvider.getUserNotes(AuthManager.loggedUser.uid);
      _listNote = notes;
      yield NoteListWidgetLoadedState(notes);
    } catch (error) {
      yield ErrorNoteListWidgetState(error);
    }
  }

  Stream<NoteListWidgetState> _mapNoteListWidgetClearSelectionEvent() async* {
    _listNoteIdSelection.clear();

    yield NoteListWidgetSelectionChangedState(
        _listNote, _listNoteIdSelection, _listNoteIdSelection.length);
  }

  Stream<NoteListWidgetState> _mapNoteListWidgetSelectionChangedEvent(
      String id) async* {
    _selectCard(id);
    yield NoteListWidgetSelectionChangedState(
        _listNote, _listNoteIdSelection, _listNoteIdSelection.length);
  }

  Stream<NoteListWidgetState> _mapDeleteSelectedNotesEvent() async* {
    yield NoteListWidgetLoadingState();
    _listNoteIdSelection.forEach((noteId) {
      StoreProvider.deleteUserNote(AuthManager.loggedUser.uid, noteId);
    });
    _listNoteIdSelection.clear();
    yield* _mapToNoteListWidgetFetchNotesEvent();
  }

  _selectCard(String id) {
    if (_listNoteIdSelection.contains(id))
      _listNoteIdSelection.remove(id);
    else
      _listNoteIdSelection.add(id);
  }
}
