import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class User extends Equatable {
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "email")
  final String email;

  User(this.name, this.email, {this.id});

  @override
  List<Object> get props => [id, name, email];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
