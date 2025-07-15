// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_object_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VaultObjectType _$VaultObjectTypeFromJson(Map<String, dynamic> json) =>
    VaultObjectType(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      isDocument: json['isDocument'] as bool,
    );

Map<String, dynamic> _$VaultObjectTypeToJson(VaultObjectType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
      'isDocument': instance.isDocument,
    };
