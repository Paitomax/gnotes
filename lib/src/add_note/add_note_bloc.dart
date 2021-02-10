import 'package:bloc/bloc.dart';
import 'package:gnotes/src/auth/auth_repository.dart';
import 'package:gnotes/src/models/note.dart';
import 'package:gnotes/src/store_provider.dart';

import 'add_note_event.dart';
import 'add_note_state.dart';

class AddNoteBloc extends Bloc<NoteEvent, AddNoteState> {
  final AuthRepository authRepository;

  AddNoteBloc(this.authRepository);

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
    final user = authRepository.getUser();
    StoreProvider.addUpdateUserNote(user.uid, note);
    yield AddNoteLoaded();
  }

  Stream<AddNoteState> _mapDeleteNote(Note note) async* {
    yield AddNoteLoading();
    final user = authRepository.getUser();
    StoreProvider.deleteUserNote(user.uid, note.id);
    yield AddNoteLoaded();
  }
}
