import 'package:bloc/bloc.dart';
import 'package:gnotes/src/auth_manager.dart';
import 'package:gnotes/src/store_provider.dart';
import 'package:gnotes/src/widgets/note_list/note_list_state.dart';

import 'note_list_event.dart';

class NoteListWidgetBloc
    extends Bloc<NoteListWidgetEvent, NoteListWidgetState> {
  List<String> _listNoteIdSelection = [];

  @override
  NoteListWidgetState get initialState =>
      NoteListWidgetSelectionChangedState([], 0);

  @override
  Stream<NoteListWidgetState> mapEventToState(
      NoteListWidgetEvent event) async* {
    if (event is NoteListWidgetSelectionChangedEvent) {
      yield* _mapNoteListWidgetSelectionChangedEvent(event.id);
    } else if (event is NoteListWidgetClearSelectionEvent) {
      yield* _mapNoteListWidgetClearSelectionEvent();
    } else if (event is DeleteSelectedNotesEvent) {
      yield* _mapDeleteSelectedNotesEvent();
    }
  }

  Stream<NoteListWidgetState> _mapNoteListWidgetClearSelectionEvent() async* {
    _listNoteIdSelection.clear();
    yield NoteListWidgetSelectionChangedState(
        _listNoteIdSelection, _listNoteIdSelection.length);
  }

  Stream<NoteListWidgetState> _mapNoteListWidgetSelectionChangedEvent(
      String id) async* {
    _selectCard(id);
    yield NoteListWidgetSelectionChangedState(
        _listNoteIdSelection, _listNoteIdSelection.length);
  }

  Stream<NoteListWidgetState> _mapDeleteSelectedNotesEvent() async* {
    _listNoteIdSelection.forEach((noteId) {
      StoreProvider.deleteUserNote(AuthManager.loggedUser.uid, noteId);
    });
    yield* _mapNoteListWidgetClearSelectionEvent();
  }

  _selectCard(String id) {
    if (_listNoteIdSelection.contains(id))
      _listNoteIdSelection.remove(id);
    else
      _listNoteIdSelection.add(id);
  }
}
