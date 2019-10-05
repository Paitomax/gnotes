import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  int id;
  String title;
  String body;
  DateTime dateTime;

  NoteModel(this.title, this.body, {this.id, this.dateTime});

  @override
  List<Object> get props => [id, title, body, dateTime];
}
