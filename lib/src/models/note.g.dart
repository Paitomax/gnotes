// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    title: json['title'] as String,
    body: json['body'] as String,
    createTime: json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String),
    lastTimeUpdated: json['lastTimeUpdated'] == null
        ? null
        : DateTime.parse(json['lastTimeUpdated'] as String),
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'createTime': instance.createTime?.toIso8601String(),
      'lastTimeUpdated': instance.lastTimeUpdated?.toIso8601String(),
    };
