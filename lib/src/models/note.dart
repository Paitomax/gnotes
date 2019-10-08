import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Note extends Equatable {
  String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "body")
  final String body;
  @JsonKey(name: "createTime")
  final DateTime createTime;
  @JsonKey(name: "lastTimeUpdated")
  final DateTime lastTimeUpdated;

  Note(this.title, this.body, this.createTime, this.lastTimeUpdated, {this.id});

  @override
  List<Object> get props => [id, title, body, createTime, lastTimeUpdated];

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
