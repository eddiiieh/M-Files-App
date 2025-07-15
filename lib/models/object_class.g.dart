// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectClass _$ObjectClassFromJson(Map<String, dynamic> json) => ObjectClass(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  displayName: json['displayName'] as String,
  objectTypeId: (json['objectTypeId'] as num).toInt(),
);

Map<String, dynamic> _$ObjectClassToJson(ObjectClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
      'objectTypeId': instance.objectTypeId,
    };
