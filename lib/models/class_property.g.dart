// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassProperty _$ClassPropertyFromJson(Map<String, dynamic> json) =>
    ClassProperty(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      dataType: (json['dataType'] as num).toInt(),
      isRequired: json['isRequired'] as bool,
      isAutomatic: json['isAutomatic'] as bool,
      isHidden: json['isHidden'] as bool,
      defaultValue: json['defaultValue'] as String?,
      valuelist:
          (json['valuelist'] as List<dynamic>?)
              ?.map((e) => PropertyValue.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ClassPropertyToJson(ClassProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
      'dataType': instance.dataType,
      'isRequired': instance.isRequired,
      'isAutomatic': instance.isAutomatic,
      'isHidden': instance.isHidden,
      'defaultValue': instance.defaultValue,
      'valuelist': instance.valuelist,
    };

PropertyValue _$PropertyValueFromJson(Map<String, dynamic> json) =>
    PropertyValue(
      displayValue: json['displayValue'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$PropertyValueToJson(PropertyValue instance) =>
    <String, dynamic>{
      'displayValue': instance.displayValue,
      'value': instance.value,
    };
