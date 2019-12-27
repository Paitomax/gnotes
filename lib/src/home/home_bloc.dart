import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gnotes/src/store_provider.dart';
import 'package:gnotes/src/widgets/note_list/note_list_bloc.dart';
import 'package:gnotes/src/widgets/note_list/note_list_state.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NoteListWidgetBloc listBloc;

  HomeBloc(this.listBloc);

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {}
}
