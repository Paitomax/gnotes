import 'package:bloc/bloc.dart';
import 'package:gnotes/src/auth_manager.dart';
import 'package:gnotes/src/store_provider.dart';

import 'add_note_event.dart';
import 'add_note_state.dart';

class AddNoteBloc extends Bloc<NoteEvent, AddNoteState> {
  @override
  AddNoteState get initialState => AddNoteUninitialized();

  @override
  Stream<AddNoteState> mapEventToState(NoteEvent event) async*{
    if (event is AddNote){
      yield AddNoteLoading();
      StoreProvider.addUpdateUserNote(AuthManager.loggedUser.uid, event.note);
      yield AddNoteLoaded();
    }
  }
}
