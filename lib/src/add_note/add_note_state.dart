import 'package:equatable/equatable.dart';

abstract class AddNoteState extends Equatable {}

class AddNoteUninitialized extends AddNoteState {
  @override
  List<Object> get props => [];
}

class AddNoteLoading extends AddNoteState {
  @override
  List<Object> get props => [];
}

class AddNoteLoaded extends AddNoteState {
  @override
  List<Object> get props => [];
}

class AddNoteError extends AddNoteState {
  final String error;

  AddNoteError(this.error);

  @override
  List<Object> get props => [error];
}
