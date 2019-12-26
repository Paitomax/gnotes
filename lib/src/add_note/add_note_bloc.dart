import 'package:bloc/bloc.dart';
import 'package:gnotes/src/auth_manager.dart';
import 'package:gnotes/src/models/note.dart';
import 'package:gnotes/src/store_provider.dart';

import 'add_note_event.dart';
import 'add_note_state.dart';

class AddNoteBloc extends Bloc<NoteEvent, AddNoteState> {
  @override
  AddNoteState get initialState => AddNoteUninitialized();

  @override
  Stream<AddNoteState> mapEventToState(NoteEvent event) async* {
    if (event is AddNote) {
      yield* _mapAddNote(event.note);
    } else if (event is DeleteNote) {
      yield* _mapDeleteNote(event.note);
    }
  }

  Stream<AddNoteState> _mapAddNote(Note note) async* {
    yield AddNoteLoading();
    StoreProvider.addUpdateUserNote(AuthManager.loggedUser.uid, note);
    yield AddNoteLoaded();
  }

  Stream<AddNoteState> _mapDeleteNote(Note note) async* {
    yield AddNoteLoading();
    StoreProvider.deleteUserNote(AuthManager.loggedUser.uid, note);
    yield AddNoteLoaded();
  }
}
