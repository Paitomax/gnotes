import 'package:bloc/bloc.dart';

import 'add_note_event.dart';
import 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  @override
  AddNoteState get initialState => AddNoteUninitialized();

  @override
  Stream<AddNoteState> mapEventToState(AddNoteEvent event) async*{
    if (event is AddNoteSubmit){
      yield AddNoteLoading();
      // add note
      yield AddNoteLoaded();
    }
  }
}
