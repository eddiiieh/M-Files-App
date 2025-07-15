// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_creation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectCreationRequest _$ObjectCreationRequestFromJson(
  Map<String, dynamic> json,
) => ObjectCreationRequest(
  objectTypeId: (json['objectTypeId'] as num).toInt(),
  classId: (json['classId'] as num).toInt(),
  propertyValues:
      (json['propertyValues'] as List<dynamic>)
          .map((e) => PropertyValueRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
  uploadId: json['uploadId'] as String?,
);

Map<String, dynamic> _$ObjectCreationRequestToJson(
  ObjectCreationRequest instance,
) => <String, dynamic>{
  'objectTypeId': instance.objectTypeId,
  'classId': instance.classId,
  'propertyValues': instance.propertyValues,
  'uploadId': instance.uploadId,
};

PropertyValueRequest _$PropertyValueRequestFromJson(
  Map<String, dynamic> json,
) => PropertyValueRequest(
  propertyId: (json['propertyId'] as num).toInt(),
  value: json['value'],
);

Map<String, dynamic> _$PropertyValueRequestToJson(
  PropertyValueRequest instance,
) => <String, dynamic>{
  'propertyId': instance.propertyId,
  'value': instance.value,
};
