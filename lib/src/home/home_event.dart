import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeFetchNotesEvent extends HomeEvent {
  final String uid;

  HomeFetchNotesEvent(this.uid);

  @override
  List<Object> get props => [uid];
}
