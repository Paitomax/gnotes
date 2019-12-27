import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gnotes/src/store_provider.dart';
import 'package:gnotes/src/widgets/note_list/note_list_bloc.dart';
import 'package:gnotes/src/widgets/note_list/note_list_state.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NoteListWidgetBloc listBloc;
  StreamSubscription otherBlocSubscription;

  HomeBloc(this.listBloc) {
    otherBlocSubscription = listBloc.listen((state) {
      if (state is NoteListWidgetSelectionChangedState){
        if (state.listNoteIdSelection.isEmpty){
          // add event
        }
        else{
          // add event
        }
      }
    });
  }

  @override
  Future<Function> close() {
    otherBlocSubscription.cancel();
    return super.close();
  }

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeFetchNotesEvent) {
      yield* _mapToHomeFetchNotesEvent(event);
    }
  }

  Stream<HomeState> _mapToHomeFetchNotesEvent(
      HomeFetchNotesEvent event) async* {
    try {
      yield LoadingHomeState();
      var notes = await StoreProvider.getUserNotes(event.uid);
      yield LoadedHomeState(notes);
    } catch (error) {
      yield ErrorHomeState(error);
    }
  }
}
