import 'package:json_annotation/json_annotation.dart';

part 'object_class.g.dart';

@JsonSerializable()
class ObjectClass {
  final int id;
  final String name;
  final String displayName;
  final int objectTypeId;

  ObjectClass({
    required this.id,
    required this.name,
    required this.displayName,
    required this.objectTypeId,
  });

  factory ObjectClass.fromJson(Map<String, dynamic> json) =>
      _$ObjectClassFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectClassToJson(this);
}