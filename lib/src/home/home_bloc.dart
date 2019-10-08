import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gnotes/src/store_provider.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
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
