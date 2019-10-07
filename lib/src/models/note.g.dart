// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    json['title'] as String,
    json['body'] as String,
    json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String),
    json['lastTimeUpdated'] == null
        ? null
        : DateTime.parse(json['lastTimeUpdated'] as String),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'createTime': instance.createTime?.toIso8601String(),
      'lastTimeUpdated': instance.lastTimeUpdated?.toIso8601String(),
    };
