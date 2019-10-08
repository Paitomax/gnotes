import 'package:equatable/equatable.dart';
import 'package:gnotes/src/models/note.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadedHomeState extends HomeState {
  final List<Note> notes;

  LoadedHomeState(this.notes);

  @override
  List<Object> get props => [notes];
}

class ErrorHomeState extends HomeState {
  final String error;

  ErrorHomeState(this.error);

  @override
  List<Object> get props => [error];
}
