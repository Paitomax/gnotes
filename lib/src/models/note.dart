import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'note.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Note extends Equatable {
  final String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "body")
  final String body;
  @JsonKey(name: "createTime")
  final DateTime createTime;
  @JsonKey(name: "lastTimeUpdated")
  final DateTime lastTimeUpdated;

  Note({
    this.id,
    @required this.title,
    @required this.body,
    @required this.createTime,
    @required this.lastTimeUpdated,
  });

  Note copyWith({
    String id,
    String title,
    String body,
    DateTime createTime,
    DateTime lastTimeUpdated,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createTime: createTime ?? this.createTime,
      lastTimeUpdated: lastTimeUpdated ?? this.lastTimeUpdated,
    );
  }

  @override
  List<Object> get props => [id, title, body, createTime, lastTimeUpdated];

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
